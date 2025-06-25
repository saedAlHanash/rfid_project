import 'package:flutter/services.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/api_manager/api_service.dart';

part 'scan_state.dart';

class ScanCubit extends MCubit<ScanInitial> {
  ScanCubit() : super(ScanInitial.initial());

  final MethodChannel _channel = MethodChannel('rfid_channel');

  Future<void> init() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));
    try {
      await _channel.invokeMethod('init');
      emit(state.copyWith(statuses: CubitStatuses.done));
    } on PlatformException catch (e) {
      loggerObject.e("Failed to init RFID: '${e.message}'.");
    }
  }

  Future<bool> dispose() async {
    try {
      return await _channel.invokeMethod('dispose');
    } on PlatformException catch (e) {
      loggerObject.e("Failed to dispose RFID: '${e.message}'.");
      return false;
    }
  }

  Future<bool> readOrStop() async {
    try {
      return await _channel.invokeMethod('readOrStop');
    } on PlatformException catch (e) {
      loggerObject.e("Failed to toggle read: '${e.message}'.");
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      return await _channel.invokeMethod('clear');
    } on PlatformException catch (e) {
      loggerObject.e("Failed to clear: '${e.message}'.");
      return false;
    }
  }

  Future<void> getStatus() async {
    try {
      final isRead = await _channel.invokeMethod('getStatus');
      emit(state.copyWith(isRead: isRead));
    } on PlatformException catch (e) {
      loggerObject.e("Failed to get status: '${e.message}'.");
      return;
    }
  }

  Future<List<String>> getData() async {
    try {
      final data = await _channel.invokeMethod('getData');
      final l = List<String>.from(data);
      return l;
    } on PlatformException catch (e) {
      loggerObject.e("Failed to get data: '${e.message}'.");
      return [];
    }
  }

  Future<bool> setReadType(int type) async {
    try {
      return await _channel.invokeMethod('setReadType', type);
    } on PlatformException catch (e) {
      loggerObject.e("Failed to set read type: '${e.message}'.");
      return false;
    }
  }
}
