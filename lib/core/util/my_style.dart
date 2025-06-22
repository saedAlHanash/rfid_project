import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';

import '../strings/app_color_manager.dart';

class MyStyle {
  //region number style

  static final double cardRadios = 0.0.r;

  //endregion

  //region margin/padding
  static final cardPadding = EdgeInsets.symmetric(horizontal: 18.w, vertical: 15.h);

  static final pagePadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 8).r;

  //endregion

  static const underLineStyle = TextStyle(fontStyle: FontStyle.italic, decoration: TextDecoration.underline);

  static var drawerShape = ShapeDecoration(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    color: AppColorManager.mainColor.withValues(alpha: 0.9),
  );

  static var normalShadow = [
    BoxShadow(color: AppColorManager.gray.withValues(alpha: 0.6), blurRadius: 15, offset: const Offset(0, 5)),
  ];

  static var lightShadow = [
    BoxShadow(color: AppColorManager.gray.withValues(alpha: 0.5), blurRadius: 5, offset: const Offset(0, 2)),
  ];

  static var allShadow = [BoxShadow(color: AppColorManager.gray.withValues(alpha: 0.5), blurRadius: 10)];
  static var allShadowDark = [
    BoxShadow(color: AppColorManager.gray.withValues(alpha: 0.6), blurRadius: 10.spMin),
  ];

  static final formBorder = OutlineInputBorder(
    borderSide: BorderSide(color: AppColorManager.offWhit.withValues(alpha: 0.27)),
    borderRadius: BorderRadius.circular(10.0.r),
  );

  static final hintStyle = TextStyle(
    fontFamily: FontManager.semeBold.name,
    fontSize: 18.0.spMin,
    color: AppColorManager.gray.withValues(alpha: 0.6),
  );
  static final textFormTextStyle = TextStyle(color: Colors.black87);

  static var roundBox = BoxDecoration(
    color: AppColorManager.lightGray,
    borderRadius: BorderRadius.circular(16.0.r),
  );

  static var roundBoxGray = BoxDecoration(
    color: AppColorManager.offWhit,
    borderRadius: BorderRadius.circular(6.0.r),
  );

  static var roundBox12 = BoxDecoration(
    color: AppColorManager.whit,
    borderRadius: BorderRadius.circular(12.0.r),
    boxShadow: MyStyle.allShadowDark,
  );

  static Widget loadingWidget({Color? color}) {
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Center(child: CircularProgressIndicator.adaptive(backgroundColor: color)),
    );
  }

  static Widget emptyWidget({dynamic? img, required String text}) {
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.0.verticalSpace,
          ImageMultiType(url: img, height: 300.0.h, width: 300.0.w),
          40.0.verticalSpace,
          DrawableText(text: text, fontWeight: FontWeight.bold, size: 24.0.sp, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  static BoxDecoration get outlineBorder => BoxDecoration(
        border: Border.all(color: Color(0xFFEDF1F3)),
        borderRadius: BorderRadius.circular(10.0.r),
      );

  static var lightShadowMainColor = [
    BoxShadow(
      color: AppColorManager.mainColor.withValues(alpha: 0.2),
      blurRadius: 5,
      offset: const Offset(0, 2),
    ),
  ];

  static final appBorderAll = Border.all(
    strokeAlign: BorderSide.strokeAlignOutside,
    color: AppColorManager.mainColor,
    width: 2.0.spMin,
  );

  static final authPagesPadding = const EdgeInsets.only(left: 40.0, right: 40.0, bottom: 30.0).r;

  static SliverGridDelegateWithFixedCrossAxisCount get productGridDelegate =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      );
}
