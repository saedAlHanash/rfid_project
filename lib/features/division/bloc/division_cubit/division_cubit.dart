import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/division/data/response/division_response.dart';

part 'division_state.dart';

class DivisionCubit extends MCubit<DivisionInitial> {
  DivisionCubit() : super(DivisionInitial.initial());

  @override
  String get nameCache => 'division';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? divisionId}) async {
    emit(state.copyWith(request: divisionId));

    await getDataAbstract(
      fromJson: Division.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Division?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.division,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Division.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setDivision(dynamic division) {
    if (division is! Division) return;

    emit(state.copyWith(result: division));
  }
}
