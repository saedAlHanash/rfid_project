import 'dart:async';
import 'dart:typed_data';

import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/features/profile/data/request/update_profile_request.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';

import '../../data/response/profile_response.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends MCubit<UpdateProfileInitial> {
  UpdateProfileCubit() : super(UpdateProfileInitial.initial());

  @override
  String get nameCache => 'updateProfile';

  Future<void> updateProfile() async {
    emit(state.copyWith(statuses: CubitStatuses.loading));

    final pair = await _updateProfileApi();

    if (pair.first == null) {
      emit(state.copyWith(error: pair.second, statuses: CubitStatuses.error));
      showErrorFromApi(state);
    } else {
      emit(state.copyWith(statuses: CubitStatuses.done, result: pair.first));
    }
  }

  void setValuesInitial() {}

  Future<Pair<ProfileResponse?, String?>> _updateProfileApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.updateProfile,
      fields: state.request.toJson(),
      files: [
        state.request.identityImage,
        state.request.profileImageUrl,
      ],
    );

    if (response.statusCode.success) {
      return Pair(ProfileResponse.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) => state.request.name = name;

  set setGender(GenderEnum? gender) => state.request.gender = gender;

  set setEducationalGrade(int? id) => state.request.educationalGradeId = id;


  set setIdentityImage(Uint8List bytes) {
    state.request.identityImage.fileBytes = bytes;
  }

  set setProfileImage(Uint8List bytes) {
    state.request.profileImageUrl.fileBytes = bytes;
  }

  set setPhone(String? phone) => state.request.phone = phone;

  set setPassword(String? password) => state.request.password = password;

  set setRePassword(String? rePassword) => state.request.rePassword = rePassword;

  String? get validateName {
    if (state.request.name == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateLocation {
    if (state.request.location == null) {
      return '${S().location} ${S().is_required}';
    }
    return null;
  }

  String? get validateBirthday {
    // if (state.request.birthday == null) {
    //   return '${S().birthday} ${S().is_required}';
    // }
    return null;
  }

  String? get validatePhone {
    if (state.request.phone == null) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.request.password == null) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }

  String? get validateRePassword {
    if (state.request.rePassword != state.request.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
