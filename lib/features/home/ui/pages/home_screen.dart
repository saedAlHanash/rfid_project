import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.mainColor,

      body: Column(
        children: [
          10.0.verticalSpace,
          ListTile(
            leading: ImageMultiType(
              url: Assets.imagesWiteLogo,
            ),
            title: DrawableText(
              text: AppProvider.getMe.entity.name,
              color: AppColorManager.whit,
            ),
            trailing: IconButton(
              onPressed: () {
                context.pushNamed(RouteName.settings);
              },
              icon: ImageMultiType(url: Assets.iconsSettings),
            ),
          ),
          20.0.verticalSpace,
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColorManager.whit,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.0.r),
                ),
              ),
              padding: EdgeInsets.only(top: 10.0).r,
              child: ListView(
                children: [
                  1.0.horizontalSpace,
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Item(image: Assets.imagesAdd, title: S.of(context).addProduct),
                        _Item(image: Assets.imagesEdit, title: S.of(context).editProduct),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Item(
                            image: Assets.imagesTransfare,
                            title: S.of(context).removeProduct),
                        _Item(
                            image: Assets.imagesDelete,
                            title: S.of(context).transferProduct),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Item(image: Assets.imagesReports, title: S.of(context).reports),
                        _Item(
                            image: Assets.imagesGetReports,
                            title: S.of(context).assetInventory),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, this.image, required this.title});

  final dynamic image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 176.0.h,
        width: 146.0.w,
        margin: EdgeInsets.all(15.0).r,
        padding: EdgeInsets.symmetric(horizontal: 23.0.w, vertical: 16.0).r,
        decoration: BoxDecoration(
          color: AppColorManager.whit,
          border: Border.all(color: AppColorManager.cd),
          borderRadius: BorderRadius.circular(12.0.r),
        ),
        child: Column(
          children: [
            Spacer(),
            ImageMultiType(
              url: image,
              height: 100.0.h,
              width: 100.0.w,
            ),
            Spacer(),
            DrawableText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
          ],
        ));
  }
}
