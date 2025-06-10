import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/router/go_router.dart';
import 'package:rfid_project/services/app_info_service.dart';

import '../../../../../core/helper/launcher_helper.dart';
import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/widgets/switch_widget.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';

class MenuScreenGuest extends StatelessWidget {
  const MenuScreenGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(zeroHeight: true),
      body: Column(
        children: [
          20.0.verticalSpace,
          CircleImageWidget(url: Assets.imagesAvatar, size: 100.0.r),
          5.0.verticalSpace,
          const DrawableText(text: 'ضيف'),
          40.0.verticalSpace,
          Expanded(
            child: Container(
              height: 1.0.sh,
              width: 1.0.sw,
              margin: const EdgeInsets.symmetric(horizontal: 10.0).r,
              decoration: BoxDecoration(
                color: AppColorManager.f9,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0.r)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    10.0.verticalSpace,
                    const ImageMultiType(url: Assets.iconsNotch),
                    30.0.verticalSpace,
                    ItemMenu(
                      onTap: () {},
                      name: S.of(context).notification,
                      subTitle: S.of(context).subTitleNotification,
                      image: Assets.iconsNotifications,
                      trailing: SwitchWidget(
                        initialVal: AppSharedPreference.getNotificationState,
                        onChange: (p0) {
                          AppSharedPreference.cashNotificationState(p0);
                        },
                      ),
                      withD: false,
                    ),
                    30.0.verticalSpace,
                    ItemMenu(
                      onTap: () {
                        LauncherHelper.openPage(AppProvider.systemParams.communicationWithSupport);
                      },
                      name: S.of(context).support,
                      subTitle: S.of(context).subTitleSupport,
                      image: Assets.iconsSupport,
                    ),
                    ItemMenu(
                      onTap: () {
                        LauncherHelper.openPage(AppProvider.systemParams.policyLink);
                      },
                      name: S.of(context).policy,
                      subTitle: S.of(context).subTitlePolicy,
                      image: Assets.iconsPolicy,
                    ),
                    ItemMenu(
                      onTap: () {
                        context.goNamed(RouteName.login);
                      },
                      name: S.of(context).login,
                      subTitle: '',
                      image: Icons.login,
                    ),
                    30.0.verticalSpace,
                    ItemMenu(name: S.of(context).buildNumber, subTitle: AppInfoService.fullVersionName),
                    ItemMenu(
                      name: S.of(context).devBy,
                      subTitle: 'الحزمة التقنية',
                      withD: false,
                      trailing: ImageMultiType(
                        url: Assets.imagesBandtechLogo,
                        height: 50.0.h,
                        width: 100.0.w,
                      ),
                    ),
                    200.0.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemMenu extends StatelessWidget {
  const ItemMenu({
    super.key,
    required this.name,
    required this.subTitle,
    this.image,
    this.trailing,
    this.withD = true,
    this.onTap,
  });

  final String name;

  final String subTitle;

  final dynamic image;
  final Function()? onTap;
  final Widget? trailing;
  final bool withD;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0).w,
      padding: const EdgeInsets.symmetric(vertical: 5.0).r,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0.r), color: Colors.white),
      child: Column(
        children: [
          ListTile(
            onTap: () => onTap?.call(),
            leading: image == null
                ? null
                : image is Widget
                ? image
                : ImageMultiType(height: 45.0.r, width: 45.0.r, url: image),
            title: DrawableText(text: name, size: 16.0.sp, fontFamily: FontManager.bold.name),
            subtitle: DrawableText(text: subTitle, size: 12.0.sp, color: Colors.grey),
            trailing: trailing,
          ),
          if (withD) Divider(height: 0, color: AppColorManager.cardColor, endIndent: 20.0.w, indent: 20.0.w),
        ],
      ),
    );
  }
}
