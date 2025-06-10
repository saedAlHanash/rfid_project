import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../generated/assets.dart';

class AuthCardImage extends StatelessWidget {
  const AuthCardImage({super.key, required this.titleText, required this.description});

  final String titleText;
  final String description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0.h,
      width: 1.0.sw,
      child: Stack(
        children: [
          PositionedDirectional(
            bottom: 20.0.h,
            start: 20.0.w,
            end: 35.0.w,
            child: Column(
              children: [
                DrawableText(
                  text: titleText,
                  size: 28.0.spMin,
                  color: Colors.white,
                  fontFamily: FontManager.bold.name,
                  matchParent: true,
                  // drawableEnd: ImageMultiType(
                  //   url: Assets.imagesLogo,
                  //   height: 80.0.r,
                  //   width: 80.0.r,
                  // ),
                ),
                10.0.verticalSpace,
                DrawableText(text: description, size: 18.0.spMin, color: Colors.white, matchParent: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
