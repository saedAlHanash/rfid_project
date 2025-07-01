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
      final power = await _channel.invokeMethod('init');
      loggerObject.w(power);
      emit(state.copyWith(statuses: CubitStatuses.done, power: power));
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

  Future<bool> setPower(int power) async {
    try {
      final b = await _channel.invokeMethod('setPower', power);
      if (b) {
        emit(state.copyWith(power: power));
      }
      return b;
    } on PlatformException catch (e) {
      loggerObject.e("Failed to dispose RFID: '${e.message}'.");
      return false;
    }
  }

  Future<void> getPower() async {
    try {
      final power = await _channel.invokeMethod('getPower');
      emit(state.copyWith(power: power));
    } on PlatformException catch (e) {
      loggerObject.e("Failed to dispose RFID: '${e.message}'.");
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
      await _channel.invokeMethod('clear');
      emit(state.copyWith(result: []));
      return true;
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

  Future<void> getData() async {
    try {
      final data = await _channel.invokeMethod('getData');
      final l = List<String>.from(data);
      emit(state.copyWith(result: l));
    } on PlatformException catch (e) {
      loggerObject.e("Failed to get data: '${e.message}'.");
      emit(state.copyWith(result: ['error ${e.message}']));
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
