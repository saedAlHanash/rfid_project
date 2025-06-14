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
          ImageMultiType(
            url: Assets.iconsLoginBack,
            height: 1.0.sh,
            width: 1.0.sw,
            fit: BoxFit.fill,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageMultiType(
                  url: Assets.imagesWiteLogo,
                  height: 75.0.r,
                  width: 75.0.r,
                ),
                DrawableText(
                  text: titleText,
                  size: 28.0.spMin,
                  color: Colors.white,
                  fontFamily: FontManager.bold.name,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
