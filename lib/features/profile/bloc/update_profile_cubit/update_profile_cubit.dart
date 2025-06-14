import 'dart:async';
import 'dart:typed_data';

import 'package:m_cubit/m_cubit.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/update_profile_request.dart';
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

  Future<Pair<UserModel?, String?>> _updateProfileApi() async {
    final response = await APIService().uploadMultiPart(
      url: PostUrl.updateProfile,
      fields: state.mRequest.toJson(),
      files: [state.mRequest.identityImage, state.mRequest.profileImageUrl],
    );

    if (response.statusCode.success) {
      return Pair(UserModel.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  set setName(String? name) => state.mRequest.name = name;

  set setGender(GenderEnum? gender) => state.mRequest.gender = gender;

  set setEducationalGrade(int? id) => state.mRequest.educationalGradeId = id;

  set setIdentityImage(Uint8List bytes) {
    state.mRequest.identityImage.fileBytes = bytes;
  }

  set setProfileImage(Uint8List bytes) {
    state.mRequest.profileImageUrl.fileBytes = bytes;
  }

  set setPhone(String? phone) => state.mRequest.phone = phone;

  set setPassword(String? password) => state.mRequest.password = password;

  set setRePassword(String? rePassword) => state.mRequest.rePassword = rePassword;

  String? get validateName {
    if (state.mRequest.name == null) {
      return S().nameEmpty;
    }
    return null;
  }

  String? get validateLocation {
    if (state.mRequest.location == null) {
      return '${S().location} ${S().is_required}';
    }
    return null;
  }

  String? get validateBirthday {
    // if (state.mRequest.birthday == null) {
    //   return '${S().birthday} ${S().is_required}';
    // }
    return null;
  }

  String? get validatePhone {
    if (state.mRequest.phone == null) {
      return '${S().email} - ${S().phoneNumber}'
          ' ${S().is_required}';
    }
    return null;
  }

  String? get validatePassword {
    if (state.mRequest.password == null) {
      return '${S().password} ${S().is_required}';
    }
    return null;
  }

  String? get validateRePassword {
    if (state.mRequest.rePassword != state.mRequest.password) {
      return S().passwordNotMatch;
    }
    return null;
  }
}
