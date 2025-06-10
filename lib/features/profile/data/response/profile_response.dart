import 'package:rfid_project/core/extensions/extensions.dart';


class UserModel {
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.isConfirmed,
    required this.fcmToken,
    required this.profileImageUrl,
    required this.identityImage,
    required this.latitude,
    required this.longitude,
    required this.gender,

  });

  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final bool isConfirmed;
  final String fcmToken;
  final String profileImageUrl;
  final String identityImage;
  final num latitude;
  final num longitude;
  final String gender;


  String get name => '$firstName $lastName';

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"].toString().tryParseOrZeroInt,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      isConfirmed: json["is_confirmed"] ?? false,
      fcmToken: json["fcm_token"] ?? "",
      profileImageUrl: json["profile_image_url"].toString().fixUrl,
      identityImage: json["identity_image"].toString().fixUrl,
      latitude: json["latitude"].toString().tryParseOrZero,
      longitude: json["longitude"].toString().tryParseOrZero,
      gender: json["gender"] ?? "",

    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "email": email,
        "is_confirmed": isConfirmed,
        "fcm_token": fcmToken,
        "profile_image_url": profileImageUrl,
        "identity_image": identityImage,
        "latitude": latitude,
        "longitude": longitude,
        "gender": gender,

      };
}

class ProfileResponse {
  ProfileResponse({
    required this.completedCourseCount,
    required this.currentCourseCount,
    required this.student,
  });

  final num completedCourseCount;
  final num currentCourseCount;
  final UserModel student;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
      completedCourseCount: json["completed_course_count"] ?? 0,
      currentCourseCount: json["current_course_count"] ?? 0,
      student: UserModel.fromJson(json["student"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "completed_course_count": completedCourseCount,
        "current_course_count": currentCourseCount,
        "student": student.toJson(),
      };
}
