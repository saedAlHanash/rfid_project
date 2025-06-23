import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/report/data/response/report_response.dart';

part 'report_state.dart';

class ReportCubit extends MCubit<ReportInitial> {
  ReportCubit() : super(ReportInitial.initial());

  @override
  String get nameCache => 'report';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? reportId}) async {
    emit(state.copyWith(request: reportId));

    await getDataAbstract(
      fromJson: Report.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Report?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.report,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Report.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setReport(dynamic report) {
    if (report is! Report) return;

    emit(state.copyWith(result: report));
  }
}
