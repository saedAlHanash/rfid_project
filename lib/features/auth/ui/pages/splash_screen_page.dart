import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/app/app_widget.dart';
import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      // if (await checkForceUpdate()) {
      //   // showUpdateDialog(ctx!, child: const UpdateDialog());
      //   // return;
      // }

      switch (getStartPage) {
        case StartPage.login:
        case StartPage.passwordOtp:
          ctx?.pushReplacementNamed(RouteName.login);
          break;
        case StartPage.home:
          ctx?.pushReplacementNamed(RouteName.home);
          break;
        case StartPage.signupOtp:
          ctx?.pushReplacementNamed(RouteName.confirmCode);
          break;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.mainColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            ImageMultiType(
              url: Assets.imagesWiteLogo,
              height: 200.0.r,
              width: 200.0.r,
            ),
            5.0.verticalSpace,
            DrawableText(
              text: 'OPDC',
              color: AppColorManager.whit,
              size: 24.0.sp,
              fontFamily: FontManager.bold.name,
            ),
            Spacer(),
            DrawableText(
              text: S.of(context).bandtech,
              color: AppColorManager.whit,
              size: 24.0.sp,
              fontFamily: FontManager.bold.name,
            ),
            DrawableText(
              text: S.of(context).designProgrammingPropertyRightsAndPublishing,
              color: AppColorManager.whit,
              fontFamily: FontManager.bold.name,
            ),
            20.0.verticalSpace,
          ],
        ),
      ),
    );
  }
}
