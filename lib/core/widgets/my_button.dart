import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';

import '../strings/app_color_manager.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.child,
    this.icon,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.height,
    this.radios,
    this.enable,
    this.toUpper = true,
    this.padding,
    this.margin,
    this.loading = false,
  });

  final Widget? child;
  final Widget? icon;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final double? height;
  final double? radios;
  final bool? enable;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function()? onTap;
  final bool toUpper;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final child =
        this.child ??
            DrawableText(
              text: toUpper ? text.toUpperCase() : text,
              color: textColor ?? AppColorManager.whit,
              fontFamily: FontManager.bold.name,
              drawableEnd: loading
                  ? SizedBox(
                height: 15.0.r,
                width: 15.0.r,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: color,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : null,
              fontWeight: FontWeight.bold,
            );

    return Container(
      width: width ?? .9.sw,
      height: height ?? 50.0.h,
      padding: margin,
      child: ElevatedButton.icon(
        icon: icon,
        label: child,
        style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(color),
          backgroundColor: WidgetStatePropertyAll(
            enable != false ? color : AppColorManager.mainColor.withValues(alpha: 0.4),
          ),
          padding: WidgetStatePropertyAll(padding ?? const EdgeInsets.symmetric(vertical: 10.0).r),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radios ?? 8.0.r)),
          ),
          alignment: Alignment.center,
        ),
        iconAlignment: IconAlignment.end,
        onPressed: loading
            ? null
            : !(enable ?? true)
            ? null
            : onTap,
      ),
    );
  }
}

class OutLineButton extends StatelessWidget {
  const OutLineButton({
    super.key,
    this.child,
    this.onTap,
    this.text = '',
    this.color,
    this.elevation,
    this.textColor,
    this.width,
    this.height,
    this.radios,
    this.enable,
    this.toUpper = true,
    this.padding,
    this.loading = false,
  });

  final Widget? child;
  final String text;
  final Color? textColor;
  final Color? color;
  final double? elevation;
  final double? width;
  final double? height;
  final double? radios;
  final bool? enable;
  final EdgeInsets? padding;
  final Function()? onTap;
  final bool toUpper;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final child =
        this.child ??
            DrawableText(
              text: toUpper ? text.toUpperCase() : text,
              color: textColor ?? AppColorManager.mainColor,
              fontFamily: FontManager.bold.name,
              size: 14.0.sp,
              drawableEnd: loading
                  ? SizedBox(
                height: 15.0.r,
                width: 15.0.r,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: color,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
                  : null,
              fontWeight: FontWeight.bold,
            );

    return SizedBox(
      width: width ?? .9.sw,
      height: height ?? 50.0.h,
      child: ElevatedButton(
        style: ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(color ?? AppColorManager.whit),
          backgroundColor: WidgetStatePropertyAll(color ?? AppColorManager.whit),
          padding: WidgetStatePropertyAll(
            height != null ? EdgeInsets.zero : padding ?? const EdgeInsets.symmetric(vertical: 13.0).r,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radios ?? 8.0.r),
              side: BorderSide(color: AppColorManager.mainColor),
            ),
          ),
          alignment: Alignment.center,
        ),
        onPressed: loading
            ? null
            : !(enable ?? true)
            ? null
            : onTap,
        child: child,
      ),
    );
  }
}
