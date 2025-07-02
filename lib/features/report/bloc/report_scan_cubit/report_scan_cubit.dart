import 'package:flutter/services.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/features/database/import_db.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/util/pair_class.dart';

part 'report_scan_state.dart';

class ReportScanCubit extends MCubit<ReportScanInitial> {
  ReportScanCubit() : super(ReportScanInitial.initial());

  final List<String> scannedLabels = [];

  Future<void> init(String roomId) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, id: roomId));
    try {
      final labels = await getLabelsByRoomId(roomId);
      emit(state.copyWith(statuses: CubitStatuses.done, result: labels, missing: labels));
    } on PlatformException catch (e) {
      emit(state.copyWith(statuses: CubitStatuses.error, result: []));
      loggerObject.e("Failed to init RFID: '${e.message}'.");
    }
  }

  Future<void> calculate(List<String> scanList) async {
    final canScan = scanList.where((label) => !scannedLabels.contains(label)).toList();

    scannedLabels.addAll(canScan);

    if (canScan.isEmpty) return;

    final scannedInfo = [[]];

    final missing = <String>[...state.missing];

    final notMatch = <String>[];

    final match = <String>[];

    final unknown = <String>[];

    final unsigned = <String>[];

    final labelNames = <String, List<String>>{};

    for (var e in canScan) {
      if (state.result.contains(e)) {
        match.add(e);
        missing.remove(e);
      } else {
        notMatch.add(e);
      }
    }

    final strange = await getMissingLabels(notMatch);

    for (var e in notMatch) {
      if (strange.contains(e)) {
        unsigned.add(e);
      } else {
        unknown.add(e);
      }
    }

    final allCanFindInDB = [...match, ...unknown];

    final names = await getProductInfoByLabels(allCanFindInDB);

    labelNames.addAll(names);

    for (var e in match) {
      scannedInfo.add(
          [e, TagStatus.match, labelNames[e]?.firstOrNull ?? '-------', labelNames[e]?.lastOrNull ?? '']);
    }
    for (var e in unknown) {
      scannedInfo.add(
          [e, TagStatus.unknown, labelNames[e]?.firstOrNull ?? '-------', labelNames[e]?.lastOrNull ?? '']);
    }
    for (var e in unsigned) {
      scannedInfo.add(
          [e, TagStatus.unsigned, labelNames[e]?.firstOrNull ?? '-------', labelNames[e]?.lastOrNull ?? '']);
    }

    emit(state.copyWith(
      missing: missing,
      match: [...state.match, ...match],
      unknown: [...state.unknown, ...unknown],
      unsigned: [...state.unsigned, ...unsigned],
      labelNames: {...state.labelNames, ...labelNames},
      scannedInfo: [...state.scannedInfo, ...scannedInfo],
    ));
  }

  Pair<String, String> labelInfo(String label) {
    final name = state.labelNames[label] ?? [];
    var status = '-';
    if (state.match.contains(label)) {
      status = 'match';
    } else if (state.unknown.contains(label)) {
      status = 'unknown';
    } else if (state.unsigned.contains(label)) {
      status = 'unsigned';
    }

    return Pair(name.firstOrNull ?? '', status);
  }

  void clear() {
    emit(
      state.copyWith(
        match: [],
        missing: [],
        unknown: [],
        unsigned: [],
      ),
    );
  }
}
