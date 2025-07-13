import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/my_button.dart';

import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../main.dart';
import '../../../../router/go_router.dart';
import '../../../../services/app_info_service.dart';
import '../widget/screens/menu_screen.dart';

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
              height: 30.0.r,
              width: 30.0.r,
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
              child: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.all(15.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                ),
                children: [
                  _Item(
                    image: Assets.imagesReports,
                    title: S.of(context).reports,
                    onTap: () {
                      context.pushNamed(RouteName.reports);
                    },
                  ),
                  _Item(
                    image: Assets.imagesGetReports,
                    title: S.of(context).assetInventory,
                    onTap: () {
                      context.pushNamed(RouteName.findRoom);
                    },
                  ),
                  _Item(
                    image: Assets.imagesAdd,
                    title: S.of(context).addProduct,
                    onTap: () {
                      context.pushNamed(RouteName.addAsset);
                    },
                  ),
                  _Item(
                    image: Assets.imagesEdit,
                    title: S.of(context).editProduct,
                    onTap: () {
                      context.pushNamed(
                        RouteName.findAsset,
                        queryParameters: {'actionType': ActionType.update.index.toString()},
                      );
                    },
                  ),
                  _Item(
                    image: Assets.imagesTransfare,
                    title: S.of(context).transferProduct,
                    onTap: () {
                      context.pushNamed(
                        RouteName.findAsset,
                        queryParameters: {'actionType': ActionType.move.index.toString()},
                      );
                    },
                  ),
                  _Item(
                    image: Assets.imagesDelete,
                    title: S.of(context).removeProduct,
                    onTap: () {
                      context.pushNamed(
                        RouteName.findAsset,
                        queryParameters: {'actionType': ActionType.delete.index.toString()},
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1.0.sw,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            color: AppColorManager.whit,
            child: Column(
              children: [
                ListTile(
                  leading: ImageMultiType(url: Assets.imagesBandtechCircle, height: 30.0.r, width: 30.0.r),
                  subtitle: DrawableText(
                    text: S.of(context).designProgrammingPropertyRightsAndPublishing,
                    size: 12.0.sp,
                  ),
                  title: DrawableText(text: S.of(context).bandtech, fontFamily: FontManager.bold.name),
                  trailing: DrawableText(
                    size: 12.0.sp,
                    color: AppColorManager.gray,
                    text: AppInfoService.fullVersionName,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({super.key, this.image, required this.title, required this.onTap});

  final dynamic image;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
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
          )),
    );
  }
}

class TestScan extends StatefulWidget {
  const TestScan({super.key});

  @override
  State<TestScan> createState() => _TestScanState();
}

class _TestScanState extends State<TestScan> {
  var l = <String>[];
  var isInit = false;
  var isRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Column(
        children: [
          MyButton(
            onTap: () {},
            text: isRead ? 'ايقاف' : 'بدأ',
          ),
          Expanded(
            child: isInit
                ? ListView.builder(
                    itemCount: l.length,
                    itemBuilder: (context, index) {
                      return DrawableText(text: l[index]);
                    },
                  )
                : MyStyle.loadingWidget(),
          ),
        ],
      ),
    );
  }
}
