import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';

class AskAuthWidget extends StatelessWidget {
  const AskAuthWidget({super.key, this.login});

  final bool? login;

  @override
  Widget build(BuildContext context) {
    return DrawableText(
      text: login == null
          ? 'أتذكر كلمة المرور الخاصة بي'
          : login!
          ? 'إنشاء حساب جديد؟'
          : 'هل لديك حساب؟',
      matchParent: true,
      padding: const EdgeInsets.symmetric(horizontal: 20.0).w,
      drawableAlin: DrawableAlin.between,
      drawableEnd: TextButton(
        onPressed: () {
          context.goNamed((login ?? false) ? RouteName.signup : RouteName.login);
        },
        child: DrawableText(
          text: (login ?? false) ? 'قم بالتسجيل' : 'تسجيل الدخول',
          color: AppColorManager.mainColor,
          fontFamily: FontManager.bold.name,
        ),
      ),
    );
  }
}
