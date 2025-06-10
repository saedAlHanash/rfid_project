 

import '../../../../core/api_manager/api_service.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/pair_class.dart';
import '../../../../generated/assets.dart';

class UpdateProfileRequest {
  UpdateProfileRequest({
    this.name,
    this.location,
    this.gender,
    this.locationName,
    // this.birthday,
    this.phone,
    this.password,
    this.rePassword,
    this.educationalGradeId,
    this.governorateId,
  });

  String? name;
  LatLng? location;
  GenderEnum? gender;
  String? locationName;
  // DateTime? birthday;
  String? phone;
  String? password;
  String? rePassword;
  int? educationalGradeId;
  int? governorateId;

  var identityImage =
  UploadFile(nameField: 'identity_image', assetImage: Assets.iconsIdentity);

  var profileImageUrl = UploadFile(
      nameField: 'profile_image_url', assetImage: Assets.iconsProfile);

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return UpdateProfileRequest(
      name: json['first_name'] as String?,
      password: json['password'] as String?,
      locationName: json['locationName'] as String?,
      educationalGradeId: json['educational_grade_id'] as int?,
      governorateId: json['governorate_id'] as int?,
      rePassword: json['rePassword'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] == null
          ? null
          : GenderEnum.values[(json['gender'] ?? 'male') == 'male' ? 0 : 1],
      // birthday: DateTime.tryParse(json['birth_date'] ?? ''),
      location: (json['latitude'] == null || json['longitude'] == null)
          ? null
          : LatLng((json['latitude'] ?? 0.0) * 1.0,
          (json['longitude'] ?? 0.0 )* 1.0),
    )
      ..profileImageUrl.initialImage = json['profile_image_url'] ?? ''
      ..identityImage.initialImage = json['identity_image'] ?? '';
  }

  Map<String, dynamic> toJson() =>
      {
        'first_name': name,
        // "password": password,
        "educational_grade_id": educationalGradeId,
        'governorate_id': governorateId,
        // 'rePassword': rePassword,
        'last_name': '.',
        // 'phone': phone,
        'gender': gender?.nameApi,
        'genderID': gender?.index,
        // 'birth_date': birthday?.toIso8601String(),
        'latitude': location?.latitude,
        'longitude': location?.longitude,
        'locationName': locationName,
      };
}
