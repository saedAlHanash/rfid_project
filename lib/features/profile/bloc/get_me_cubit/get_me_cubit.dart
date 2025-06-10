import 'package:m_cubit/m_cubit.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:rfid_project/features/profile/data/response/profile_response.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';

part 'get_me_state.dart';

class GetMeCubit extends MCubit<GetMeInitial> {
  GetMeCubit() : super(GetMeInitial.initial());

  @override
  String get nameCache => 'profile';

  Future<void> getData({bool newData = false}) async {
    getDataAbstract(
      fromJson: ProfileResponse.fromJson,
      state: state,
      getDataApi: _getDataApi,
      newData: newData,
    );
  }

  Future<Pair<ProfileResponse?, String?>> _getDataApi() async {
    final response = await APIService().callApi(type: ApiType.get, url: GetUrl.profile);

    if (response.statusCode.success) {
      final pair = Pair(ProfileResponse.fromJson(response.jsonBodyPure), null);
      await AppSharedPreference.cashUser(pair.first.student);
      return pair;
    } else {
      return response.getPairError;
    }
  }
}
