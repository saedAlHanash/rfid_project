import '../../../profile/data/response/profile_response.dart';

class LoginResponse {
  LoginResponse({
    required this.user,
    required this.token,
  });

  final UserModel user;
  final String token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      user: UserModel.fromJson(json["user"] ?? {}),
      token: json["token"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "token": token,
      };
}

