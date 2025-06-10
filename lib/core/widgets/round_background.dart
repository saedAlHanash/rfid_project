import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../generated/assets.dart';

class RoundBackground extends StatelessWidget {
  const RoundBackground({super.key, required this.child, this.width, this.height});

  final Widget child;
  final double ?width;
  final double ?height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:width?? 0.7.sw,
      height:height?? 55.0.h,
      child: Stack(
        children: [
          ImageMultiType(
            url: Assets.iconsRound,
            fit: BoxFit.fill,
            height: 1.0.sh,
            width: 1.0.sw,
          ),
        child,
        ],
      ),
    );
  }
}
