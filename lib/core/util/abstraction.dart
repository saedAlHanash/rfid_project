// import 'package:rfid_project/core/extensions/extensions.dart';
// import 'package:equatable/equatable.dart';import 'package:m_cubit/m_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive/hive.dart';
//
// import '../../services/caching_service/caching_service.dart';
// import '../api_manager/api_service.dart';
// import '../error/error_manager.dart';
// import '../strings/enum_manager.dart';
//
// abstract class AbstractState<T> extends Equatable {
//   final CubitStatuses statuses;
//   final String error;
//   final T result;
//   final dynamic request;
//
//   String get filter => request?.toString().getKey ?? '';
//
//   const AbstractState({
//     this.statuses = CubitStatuses.init,
//     this.error = '',
//     this.request,
//     required this.result,
//   });
//
//   bool get loading => statuses == CubitStatuses.loading;
//
//   bool get isDataEmpty =>
//       (statuses != CubitStatuses.loading) &&
//       (result is List) &&
//       ((result as List).isEmpty);
// }
//
// class StateControl {
//   String? error;
//   dynamic request;
//
//   StateControl();
// }
//
// abstract class MCubit<AbstractState> extends Cubit<AbstractState> {
//   MCubit(super.initialState);
//
//   String get nameCache => '';
//
//   String get filter => '';
//
//   int get timeInterval => 60;
//
//   Future<Box<String>> get box => CachingService.getBox(nameCache);
//
//   Future<NeedUpdateEnum> _needGetData() async {
//     return await CachingService.needGetData(this);
//   }
//
//   Future<void> storeData(dynamic data) async {
//     await CachingService.sortData(this, data: data);
//   }
//
//   Future<Iterable<dynamic>?> addOrUpdateDate(List<dynamic> data) async {
//     return await CachingService.addOrUpdate(this, data: data);
//   }
//
//   Future<Iterable<dynamic>?> deleteDate(List<String> ids) async {
//     return await CachingService.delete(this, ids: ids);
//   }
//
//   Future<List<T>> getListCached<T>({
//     required T Function(Map<String, dynamic>) fromJson,
//   }) async {
//     final data = await CachingService.getList(this);
//
//     return data.map((e) {
//       try {
//         return fromJson(e);
//       } catch (e) {
//         return fromJson({});
//       }
//     }).toList();
//   }
//
//   Future<T> getDataCached<T>({
//     required T Function(Map<String, dynamic>) fromJson,
//   }) async {
//     final json = await CachingService.getData(this);
//     try {
//       return fromJson(json);
//     } catch (e) {
//       return fromJson({});
//     }
//   }
//
//   Future<bool> checkCashed<T>({
//     required dynamic state,
//     required T Function(Map<String, dynamic>) fromJson,
//     bool newData = false,
//     void Function(dynamic data, CubitStatuses emitState)? onSuccess,
//   }) async {
//     if (newData || nameCache.isEmpty) {
//       emit(state.copyWith(statuses: CubitStatuses.loading));
//       return false;
//     }
//
//     try {
//       final cacheType = await _needGetData();
//
//       dynamic data;
//
//       if (state.result is List) {
//         data = await getListCached(fromJson: fromJson);
//       } else {
//         data = await getDataCached(fromJson: fromJson);
//       }
//
//       if (onSuccess != null) {
//         onSuccess.call(data, cacheType.getState);
//       } else {
//         emit(
//           state.copyWith(
//             result: data,
//             statuses: cacheType.getState,
//           ),
//         );
//       }
//
//       if (cacheType == NeedUpdateEnum.no) return true;
//
//       return false;
//     } catch (e) {
//       loggerObject.e('checkCashed  $nameCache: $e');
//
//       return false;
//     }
//   }
//
//   Future<void> getDataAbstract<T>({
//     required T Function(Map<String, dynamic>) fromJson,
//     required dynamic state,
//     required Function getDataApi,
//     bool newData = false,
//     void Function()? onError,
//     void Function(dynamic data, CubitStatuses emitState)? onSuccess,
//   }) async {
//
//     final checkData = await checkCashed(
//       state: state,
//       fromJson: fromJson,
//       newData: newData,
//       onSuccess: onSuccess,
//     );
//
//     if (checkData) {
//       loggerObject.f('$nameCache stopped on cache');
//       return;
//     }
//
//     final pair = await getDataApi.call();
//
//     if (pair.first == null) {
//       if (isClosed) return;
//
//       final s = state.copyWith(statuses: CubitStatuses.error, error: pair.second);
//
//       emit(s);
//
//       showErrorFromApi(s);
//       onError?.call();
//     } else {
//       await storeData(pair.first);
//
//       if (onSuccess != null) {
//         onSuccess.call(pair.first, CubitStatuses.done);
//       } else {
//         if (isClosed) return;
//         emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
//       }
//     }
//   }
// }
//
