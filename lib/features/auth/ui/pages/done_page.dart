import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/my_button.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';

class DonePage extends StatelessWidget {
  const DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          200.0.verticalSpace,
          ImageMultiType(url: Assets.iconsDone, height: 90.0.r, width: 90.0.r),
          20.0.verticalSpace,
          DrawableText(
            text: S.of(context).isSuccess,
            size: 24.0.sp,
            fontFamily: FontManager.bold.name,
            textAlign: TextAlign.center,
          ),
          200.0.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 70.0).r,
            child: MyButton(
              onTap: () {
                context.goNamed(RouteName.login);
              },
              text: S.of(context).done,
            ),
          ),
        ],
      ),
    );
  }
}
