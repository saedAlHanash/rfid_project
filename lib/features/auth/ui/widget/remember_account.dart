import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';

class RememberAccount extends StatelessWidget {
  const RememberAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DrawableText(
        text: S.of(context).iRememberedMyPassword,
        color: AppColorManager.gray,
        drawablePadding: 7.0.w,
        drawableEnd: InkWell(
          onTap: () {
            AppSharedPreference.removePhone().then((value) {
              ctx?.pushNamed(RouteName.login);
            });
          },
          child: DrawableText(
            color: AppColorManager.mainColor,
            fontFamily: FontManager.bold.name,
            text: '${S.of(context).login}.',
          ),
        ),
      ),
    );
  }
}
