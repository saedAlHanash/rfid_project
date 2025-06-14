import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/circle_image_widget.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
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
      backgroundColor: AppColorManager.mainColor,
      appBar: AppBarWidget(titleText: S.of(context).settings),
      body: BlocBuilder<GetMeCubit, GetMeInitial>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: AppColorManager.whit,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0.r),
              ),
            ),
            padding: EdgeInsets.all(20.0).r,
            child: Column(
              children: [
                MyTextFormOutLineWidget(
                  enable: false,
                  label: 'تاريخ غلق الحساب',
                  initialValue: state.result.expiryDate?.formatDate,
                ),
                MyTextFormOutLineWidget(
                  enable: false,
                  initialValue: state.result.name,
                  label: 'اسم المستخدم',
                ),
                MyTextFormOutLineWidget(
                  enable: false,
                  initialValue: state.result.phone,
                  label: 'رقم الهاتف',
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextFormOutLineWidget(
                        enable: false,
                        initialValue: '10',
                        label: 'طاقة القراءة',
                      ),
                    ),
                    15.0.horizontalSpace,
                    Expanded(
                      child: MyTextFormOutLineWidget(
                        enable: false,
                        initialValue: '30',
                        label: 'طاقة الجرد',
                      ),
                    ),
                  ],
                ),
                MyTextFormOutLineWidget(
                  enable: false,
                  label: 'الصلاحيات',
                  iconWidgetLift: Column(
                    children: [
                      20.0.verticalSpace,
                      ListTile(
                        title: DrawableText(text: 'القسم'),
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          width: 10.0.r,
                        ),
                      ),
                      ListTile(
                        title: DrawableText(text: 'الهيئة'),
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          width: 10.0.r,
                        ),
                      ),
                      ListTile(
                        title: DrawableText(text: 'الشعبة'),
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          width: 10.0.r,
                        ),
                      ),
                      ListTile(
                        title: DrawableText(text: 'الغرفة '),
                        trailing: ImageMultiType(
                          url: Icons.arrow_forward_ios,
                          width: 10.0.r,
                        ),
                      ),
                      20.0.verticalSpace,
                    ],
                  ),
                ),
                // ItemMenu(
                //   onTap: () {
                //     AppProvider.logout();
                //   },
                //   name: S.of(context).logout,
                //   subTitle: '',
                //   image: Assets.iconsLogout,
                // ),
                ListTile(
                  onTap: () {
                    AppProvider.logout();
                  },
                  title: DrawableText(text: S.of(context).logout),
                  trailing: ImageMultiType(
                    url: Icons.logout,
                    height: 15.0.r,
                    color: AppColorManager.mainColor,
                  ),
                ),
                Spacer(),
                Bandtech(),
                20.0.verticalSpace,
              ],
            ),
          );
        },
      ),
    );
  }
}

class Bandtech extends StatelessWidget {
  const Bandtech({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageMultiType(
          url: Assets.imagesBandtechCircle,
          height: 35.0.r,
          width: 35.0.r,
        ),
        DrawableText(
          text: S.of(context).bandtech,
          size: 24.0.sp,
          fontFamily: FontManager.bold.name,
        ),
        DrawableText(
          text: S.of(context).designProgrammingPropertyRightsAndPublishing,
          fontFamily: FontManager.bold.name,
        ),
      ],
    );
  }
}
