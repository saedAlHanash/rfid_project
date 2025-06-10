import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:rfid_project/features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import 'package:rfid_project/router/go_router.dart';
import 'package:rfid_project/services/app_info_service.dart';

import '../../../../../core/helper/launcher_helper.dart';
import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/util/snack_bar_message.dart';
import '../../../../../core/widgets/switch_widget.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../profile/bloc/get_me_cubit/get_me_cubit.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarWidget(zeroHeight: true),
      body: BlocBuilder<GetMeCubit, GetMeInitial>(
        builder: (context, state) {
          return Column(
            children: [
              20.0.verticalSpace,
              CircleImageWidget(url: AppProvider.getMe.profileImageUrl, size: 100.0.r),
              5.0.verticalSpace,
              DrawableText(text: AppProvider.getMe.firstName),
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
                  child: RefreshWidget(
                    isLoading: state.loading,
                    onRefresh: () {
                      context.read<GetMeCubit>().getData(newData: true);
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          10.0.verticalSpace,

                          // 30.0.verticalSpace,
                          // ItemMenu(
                          //   onTap: () {
                          //     context.pushNamed(RouteName.profile).then((value) {
                          //       if (value is bool && value) {
                          //         context.read<GetMeCubit>().getData(newData: true);
                          //       }
                          //     });
                          //   },
                          //   name: S.of(context).profile,
                          //   subTitle: S.of(context).profile,
                          //   image: Assets.iconsProfile,
                          // ),
                          //
                          // ItemMenu(
                          //   onTap: () {},
                          //   name: S.of(context).notification,
                          //   subTitle: S.of(context).subTitleNotification,
                          //   // subTitle: AppProvider.eduGrade.name,
                          //   image: Assets.iconsNotifications,
                          //   trailing: SwitchWidget(
                          //     initialVal: AppSharedPreference.getNotificationState,
                          //     onChange: (p0) {
                          //       AppSharedPreference.cashNotificationState(p0);
                          //     },
                          //   ),
                          //   withD: false,
                          // ),
                          // 30.0.verticalSpace,
                          // ItemMenu(
                          //   onTap: () {},
                          //   name: S.of(context).password,
                          //   subTitle: S.of(context).subTitlePassword,
                          //   image: Assets.iconsPassword,
                          // ),
                          // ItemMenu(
                          //   onTap: () {
                          //     LauncherHelper.openPage(AppProvider.systemParams.communication);
                          //   },
                          //   name: S.of(context).support,
                          //   subTitle: S.of(context).subTitleSupport,
                          //   image: Assets.iconsSupport,
                          // ),
                          // ItemMenu(
                          //   onTap: () {
                          //     LauncherHelper.openPage(AppProvider.systemParams.policyLink);
                          //   },
                          //   name: S.of(context).policy,
                          //   subTitle: S.of(context).subTitlePolicy,
                          //   image: Assets.iconsPolicy,
                          // ),
                          // ItemMenu(
                          //   onTap: () {
                          //     AppProvider.logout();
                          //   },
                          //   name: S.of(context).logout,
                          //   subTitle: '',
                          //   image: Assets.iconsLogout,
                          // ),
                          // ItemMenu(
                          //   onTap: () {
                          //     NoteMessage.showCheckDialog(
                          //       context,
                          //       text: 'حذف الحساب',
                          //       textButton: 'متأكد',
                          //       image: ImageMultiType(
                          //         url: Assets.iconsDelete,
                          //         height: 120.0.r,
                          //         width: 120.0.r,
                          //       ),
                          //       onConfirm: () {
                          //         context.read<DeleteAccountCubit>().deleteAccount(context);
                          //       },
                          //     );
                          //   },
                          //   name: S.of(context).deleteAccount,
                          //   subTitle: S.of(context).subTitleDeleteAccount,
                          //   image: Assets.iconsDelete,
                          //   withD: false,
                          // ),
                          30.0.verticalSpace,
                          ItemMenu(
                            onTap: () {},
                            name: S.of(context).buildNumber,
                            subTitle: AppInfoService.fullVersionName,
                          ),
                          ItemMenu(
                            onTap: () {},
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
              ),
            ],
          );
        },
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
