import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';

import '../../../../core/util/pair_class.dart';
import '../../../../generated/assets.dart';

class SignupRequest {
  SignupRequest({
    this.name,
    this.location,
    this.gender,
    this.locationName,
    this.birthday,
    this.phone,
    this.password,
    this.rePassword,
    this.governorateId,
    this.educationalGradeId,
  }) {
    if (AppProvider.isTestMode) {
      password = '12345678';
      rePassword = '12345678';
    }
  }

  String? name;
  LatLng? location;
  int? governorateId;
  GenderEnum? gender;
  String? locationName;
  DateTime? birthday;
  String? phone;
  String? password;
  String? rePassword;
  int? educationalGradeId;

  factory SignupRequest.fromJson(Map<String, dynamic> json) {
    return SignupRequest(
      name: json['first_name'] as String?,
      password: json['password'] as String?,
      locationName: json['locationName'] as String?,
      educationalGradeId: json['educational_grade_id'] as int?,
      rePassword: json['rePassword'] as String?,
      phone: json['phone'] as String?,
      governorateId: json['governorate_id'] as int?,
      gender: json['genderID'] == null ? null : GenderEnum.values[json['genderID'] ?? 0],
      birthday: DateTime.tryParse(json['birth_date'] ?? ''),
      location: (json['latitude'] == null || json['longitude'] == null)
          ? null
          : LatLng(json['latitude'] ?? 0, json['longitude'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() => {
    'first_name': name,
    "password": password,
    "educational_grade_id": educationalGradeId,
    'rePassword': rePassword,
    'last_name': '.',
    'phone': phone.fixPhone,
    'gender': gender?.nameApi ?? 'male',
    'genderID': gender?.index ?? 0,
    'birth_date': birthday?.toIso8601String() ?? DateTime(2000).toIso8601String(),
    'latitude': location?.latitude.toString(),
    'longitude': location?.longitude.toString(),
    'locationName': locationName,
    'governorate_id': governorateId,
  };
}
