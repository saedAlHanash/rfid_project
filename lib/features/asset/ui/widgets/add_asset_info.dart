import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../data/request/create_asset_request.dart';

class AddAssetInfo extends StatelessWidget {
  const AddAssetInfo({super.key, required this.data});

  final CreateAssetRequest data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyStyle.outlineBorder,
      padding: EdgeInsets.all(16.0).r,
      child: Column(
        children: [
          10.0.verticalSpace,
          DrawableText(
            matchParent: true,
            text: S.of(context).assetName,
            fontWeight: FontWeight.bold,
            drawableEnd: DrawableText(
              text: data.asset.name,
              color: Colors.grey,
            ),
          ),
          10.0.verticalSpace,
          DrawableText(
            matchParent: true,
            text: S.of(context).department,
            fontWeight: FontWeight.bold,
            drawableEnd: DrawableText(
              text: data.department.name,
              color: Colors.grey,
            ),
          ),
          10.0.verticalSpace,
          DrawableText(
            matchParent: true,
            text: S.of(context).department,
            fontWeight: FontWeight.bold,
            drawableEnd: DrawableText(
              text: data.department.name,
              color: Colors.grey,
            ),
          ),
          10.0.verticalSpace,
          DrawableText(
            matchParent: true,
            text: S.of(context).division,
            fontWeight: FontWeight.bold,
            drawableEnd: DrawableText(
              text: data.division.name,
              color: Colors.grey,
            ),
          ),
          10.0.verticalSpace,
          DrawableText(
            matchParent: true,
            text: S.of(context).room,
            fontWeight: FontWeight.bold,
            drawableEnd: DrawableText(
              text: data.room.name,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
