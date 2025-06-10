import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';

import '../../../../core/util/shared_preferences.dart';

class ResendRequest {
  ResendRequest({
    this.phone,
    this.type,
  });

  String? phone;
  ResendCodeType? type;

  factory ResendRequest.fromJson(Map<String, dynamic> json) {
    return ResendRequest(
      phone: json["phone"] ?? "",
      type: json["type"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "phone": phone?.fixPhone ?? AppSharedPreference.getPhone.fixPhone,
        "type": type?.nameApi ?? ResendCodeType.whatsapp.nameApi,
      };
}
