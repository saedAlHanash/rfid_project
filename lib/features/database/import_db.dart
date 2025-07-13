import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/error/error_manager.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/util/pair_class.dart';

var isImport = false;
var isImporting = false;

Future<void> importNewDatabaseFromApi({bool fourceImport = false}) async {
  try {
    if (fourceImport) isImport = false;
    if (isImport || !AppProvider.isLogin) return;
    isImport = true;
    final response = await APIService().callApi(
      url: 'export-sqlite',
      type: ApiType.get,
    );

    if (!response.statusCode.success) {
      isImport = false;
      showErrorFromApiNorma((response.getPairError as Pair).second);
      return;
    }

    final zipFile = await downloadZipFile(response.jsonBodyPure['url'] ?? '');

    final sqliteFile = await extractSqliteFromZip(zipFile);
    await openNewDatabase();
    isImport = true;
    loggerObject.i('تم استيراد القاعدة بنجاح: ${sqliteFile.path}');
    // يمكنك الآن استخدام db كقاعدة بيانات جديدة
  } catch (e) {
    loggerObject.i('خطأ أثناء الاستيراد: $e');
  }
}

Future<List<String>> getLabelsByRoomId(String roomId) async {
  final db = await openDatabaseFromPath();

  final result = await db.query(
    'asset_items',
    columns: ['label'],
    where: 'room_id = ?',
    whereArgs: [roomId],
  );

  // تحويل النتائج إلى قائمة نصوص
  return result.map((row) => row['label'] as String).toList();
}

Future<List<Map<String, dynamic>>> getAssetItems({
  String? status,
  String? roomId,
}) async {
  final db = await openDatabaseFromPath();
  final whereClauses = <String>[];
  final whereArgs = <dynamic>[];

  if (status != null) {
    whereClauses.add('status = ?');
    whereArgs.add(status);
  }
  if (roomId != null) {
    whereClauses.add('room_id = ?');
    whereArgs.add(roomId);
  }

  final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

  return db.query('asset_items', where: whereString, whereArgs: whereArgs);
}

Future<Map<String, List<String>>> getProductInfoByLabels(List<String> labels) async {
  final db = await openDatabaseFromPath();

  if (labels.isEmpty) return {};

  // 1. استعلام واحد لجلب كل asset_items التي لها label مطلوب
  final items = await db.query(
    'asset_items',
    where: 'label IN (${List.filled(labels.length, '?').join(',')})',
    whereArgs: labels,
  );

  // 2. بناء خريطة: label -> asset_id
  final Map<String, String> labelToAssetId = {
    for (var item in items) item['label'] as String: item['asset_id'] as String
  };

  // 3. تجميع asset_ids المطلوبة
  final assetIds = labelToAssetId.values.toSet().toList();

  if (assetIds.isEmpty)
    return {
      for (final label in labels) label: ['غير معروف', '']
    };

  // 4. استعلام واحد لجلب أسماء المنتجات والصور
  final assets = await db.query(
    'assets',
    columns: ['id', 'name', 'image'],
    where: 'id IN (${List.filled(assetIds.length, '?').join(',')})',
    whereArgs: assetIds,
  );

  // 5. بناء خريطة: asset_id -> [name, image]
  final Map<String, List<String>> assetIdToInfo = {
    for (var asset in assets)
      asset['id'] as String: [
        asset['name'] as String? ?? 'غير معروف',
        asset['image'] as String? ?? '',
      ]
  };

  // 6. بناء النتيجة كـ Map<label, [name, image]>
  final Map<String, List<String>> result = {};

  for (final label in labels) {
    final assetId = labelToAssetId[label];
    final info = assetId != null ? (assetIdToInfo[assetId] ?? ['غير معروف', '']) : ['غير معروف', ''];
    result[label] = info;
  }

  return result;
}

Future<List<Map<String, dynamic>>> getRooms() async {
  final db = await openDatabaseFromPath();
  final whereClauses = <String>[];
  final whereArgs = <dynamic>[];

  final whereString = whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null;

  return db.query('asset_items', where: whereString, whereArgs: whereArgs);
}

Future<List<Map<String, dynamic>>> searchAssetsByName(String keyword) async {
  final db = await openDatabaseFromPath();
  return db.query(
    'assets',
    where: 'name LIKE ?',
    whereArgs: ['%$keyword%'],
  );
}

Future<List<Map<String, dynamic>>> getDepartmentsByEntity(String entityId) async {
  final db = await openDatabaseFromPath();
  return db.query(
    'departments',
    where: 'entity_id = ?',
    whereArgs: [entityId],
  );
}

Future<List<Map<String, dynamic>>> getDivisionsByDepartment(String deptId) async {
  final db = await openDatabaseFromPath();
  return db.query(
    'divisions',
    where: 'department_id = ?',
    whereArgs: [deptId],
  );
}

Future<List<Map<String, dynamic>>> getReportsInDateRange(String fromDate, String toDate) async {
  final db = await openDatabaseFromPath();
  return db.query(
    'reports',
    where: 'created_at >= ? AND created_at <= ?',
    whereArgs: [fromDate, toDate],
  );
}

Future<List<Map<String, dynamic>>> getAssetItemsWithAssetNames() async {
  final db = await openDatabaseFromPath();
  return db.rawQuery('''
    SELECT asset_items.*, assets.name as asset_name
    FROM asset_items
    LEFT JOIN assets ON asset_items.asset_id = assets.id
  ''');
}

Future<List<String>> getMissingLabels(List<String> labels) async {
  if (labels.isEmpty) return [];

  final db = await openDatabaseFromPath();

  final placeholders = List.filled(labels.length, '?').join(', ');

  final result = await db.rawQuery(
    'SELECT label FROM asset_items WHERE label IN ($placeholders)',
    labels,
  );

  final existingLabels = result.map((row) => row['label'] as String).toSet();

  final missing = labels.where((label) => !existingLabels.contains(label)).toList();

  return missing;
}

Future<List<String>> getMissingRoomNames(List<String> roomNames) async {
  if (roomNames.isEmpty) return [];

  final db = await openDatabaseFromPath();

  final placeholders = List.filled(roomNames.length, '?').join(', ');
  final result = await db.rawQuery(
    'SELECT name FROM rooms WHERE name IN ($placeholders)',
    roomNames,
  );

  final existingNames = result.map((row) => row['name'] as String).toSet();

  final missing = roomNames.where((name) => !existingNames.contains(name)).toList();

  return missing;
}

Future<Database> openDatabaseFromPath() async {
  final dir = await getApplicationDocumentsDirectory();
  final path = '${dir.path}/app_data.sqlite';
  return openDatabase(path);
}

Future<Database> openNewDatabase() async {
  final dir = await getApplicationDocumentsDirectory();
  final dbPath = '${dir.path}/app_data.sqlite';
  return await openDatabase(dbPath);
}

Future<File> extractSqliteFromZip(File zipFile) async {
  final bytes = await zipFile.readAsBytes();
  final archive = ZipDecoder().decodeBytes(bytes);

  final appDir = await getApplicationDocumentsDirectory();
  final dbPath = '${appDir.path}/app_data.sqlite';

  // حذف الملف القديم
  final oldDb = File(dbPath);
  if (await oldDb.exists()) await oldDb.delete();

  // استخراج الملف الجديد
  for (final file in archive) {
    if (file.name.endsWith('.sqlite')) {
      final extracted = File(dbPath);
      await extracted.writeAsBytes(file.content as List<int>);
      return extracted;
    }
  }

  throw Exception('لم يتم العثور على ملف SQLite داخل الملف المضغوط.');
}

Future<File> downloadZipFile(String url) async {
  final response = await http.get(Uri.parse(url));
  final tempDir = await getTemporaryDirectory();
  final zipFile = File('${tempDir.path}/app_data.zip');
  await zipFile.writeAsBytes(response.bodyBytes);
  return zipFile;
}

Future<void> insertAssetItems(List<AssetItem> items) async {
  final Database db = await openDatabase('your_database.db'); // أو استخدم getDatabase()

  Batch batch = db.batch();

  for (final item in items) {
    batch.insert(
      'asset_items',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  await batch.commit(noResult: true);
}

Future<void> updateAssetItem(AssetItem item) async {
  final Database db = await openDatabase('your_database.db'); // أو getDatabase()

  await db.update(
    'asset_items',
    item.toJson(),
    where: 'id = ?',
    whereArgs: [item.id],
  );
}

class AssetItem {
  final int? id; // null عند الإدخال الجديد
  final String assetId;
  final String clientId;
  final String label;
  final String status;
  final String roomId;
  final String createdAt;
  final String updatedAt;

  AssetItem({
    this.id,
    required this.assetId,
    required this.clientId,
    required this.label,
    required this.status,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    final map = {
      'asset_id': assetId,
      'client_id': clientId,
      'label': label,
      'status': status,
      'room_id': roomId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };

    if (id != null) {
      map['id'] = id.toString();
    }

    return map;
  }
}
