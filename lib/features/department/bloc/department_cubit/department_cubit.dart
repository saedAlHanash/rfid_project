import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/department/data/response/department_response.dart';
import 'package:m_cubit/abstraction.dart';

part 'department_state.dart';

class DepartmentCubit extends MCubit<DepartmentInitial> {
  DepartmentCubit() : super(DepartmentInitial.initial());

  @override
  String get nameCache => 'department';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false,  String? departmentId}) async {
    emit(state.copyWith(request: departmentId));

    await getDataAbstract(
      fromJson: Department.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Department?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.department,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Department.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setDepartment(dynamic department) {
    if (department is! Department) return;

    emit(state.copyWith(result: department));
  }
}
 