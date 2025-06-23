import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/report/data/request/create_report_request.dart';
import 'package:rfid_project/features/report/data/response/report_response.dart';

import '../../../../core/error/error_manager.dart';

part 'reports_state.dart';

class ReportsCubit extends MCubit<ReportsInitial> {
  ReportsCubit() : super(ReportsInitial.initial());

  @override
  String get nameCache => 'reports';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(fromJson: Report.fromJson, state: state);

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Report.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Report>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.reports,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Reports.fromJson(response.jsonBody).items, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createReport,
      body: state.cRequest.toJson(),
    );

    await _updateState(response);
  }

  Future<void> update() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateReport,
      query: {'id': state.cRequest.id},
      body: state.cRequest.toJson(),
    );
    await _updateState(response);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteReport,
      query: {'id': state.id},
    );

    await _updateState(response, isDelete: true);
  }

  Future<void> deleteNow({required String id}) async {
    final index = state.result.indexWhere((element) => element.id == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteReport,
      query: {'id': state.id},
    );

    if (response.statusCode.success) {
      await deleteReportFromCache(item.id);
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = Report.fromJson(response.jsonBody);
      isDelete ? await deleteReportFromCache(state.id) : await addOrUpdateReportToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      showErrorFromApi(state);
      emit(state.copyWith(statuses: CubitStatuses.error));
    }
  }

  //endregion

  Future<void> addOrUpdateReportToCache(Report item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Report.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteReportFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Report.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
