import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';

import '../../data/response/asset_response.dart';

class ItemAsset extends StatelessWidget {
  const ItemAsset({super.key, required this.asset});

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.r),
        color: AppColorManager.lightGray,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0).r,
      child: ListTile(
        onTap: () {},
        title: DrawableText(text: asset.name),
        subtitle: DrawableText(text: asset.note),
        leading: ImageMultiType(
          url: asset.image,
          height: 30.0.r,
          width: 30.0.r,
        ),
        trailing: ImageMultiType(url: Icons.arrow_forward_ios, height: 20.0.r, color: Colors.grey),
      ),
    );
  }
}
