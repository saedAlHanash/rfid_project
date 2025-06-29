import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:sqflite/sqflite.dart';

Future<void> importNewDatabaseFromApi() async {
  final zipUrl = 'https://jaradalasul.com/storage/app_data.zip';

  try {
    final zipFile = await downloadZipFile(zipUrl);
    final sqliteFile = await extractSqliteFromZip(zipFile);
    final db = await openNewDatabase();

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

Future<Map<String, String>> getProductNamesByLabels(List<String> labels) async {
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

  // 4. استعلام واحد لجلب أسماء المنتجات
  final assets = await db.query(
    'assets',
    where: 'id IN (${List.filled(assetIds.length, '?').join(',')})',
    whereArgs: assetIds,
  );

  // 5. بناء خريطة: asset_id -> name
  final Map<String, String> assetIdToName = {
    for (var asset in assets) asset['id'] as String: asset['name'] as String
  };

  // 6. بناء النتيجة كـ Map<label, name>
  final Map<String, String> result = {};

  for (final label in labels) {
    final assetId = labelToAssetId[label];
    final name = assetId != null ? (assetIdToName[assetId] ?? 'غير معروف') : 'غير معروف';
    result[label] = name;
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

Future<List<Map<String, dynamic>>> getReportsInDateRange(
    String fromDate, String toDate) async {
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

  // أولًا، نحصل على كل الـ labels الموجودة فعليًا في الجدول
  final placeholders = List.filled(labels.length, '?').join(', ');
  final result = await db.rawQuery(
    'SELECT label FROM asset_items WHERE label IN ($placeholders)',
    labels,
  );

  // تحويل النتائج إلى Set لسهولة المقارنة
  final existingLabels = result.map((row) => row['label'] as String).toSet();

  // استخراج الفرق بين الاثنين
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
