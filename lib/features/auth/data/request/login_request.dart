import 'package:rfid_project/core/extensions/extensions.dart';


class LoginRequest {
  String? phone;
  String? password;
  String? code;

  LoginRequest({
    this.phone,
    this.password,
    this.code,
  });

  LoginRequest copyWith({
    String? phone,
    String? password,
  }) {
    return LoginRequest(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Future<Map<String, dynamic>> toJson() async {
    return {
      'phone': phone.fixPhone,
      'password': password,
      'verification_code': code,
      'token': code,

    };
  }
}
