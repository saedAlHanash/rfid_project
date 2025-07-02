import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/core/widgets/spinner_widget.dart';
import 'package:rfid_project/services/app_info_service.dart';

import '../../../../../core/strings/app_color_manager.dart';
import '../../../../../core/strings/app_string_manager.dart';
import '../../../../../core/util/my_style.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/l10n.dart';
import '../../../../profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../../../scan/bloc/scan_cubit/scan_cubit.dart';

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
      body: BlocBuilder<ScanCubit, ScanInitial>(
        builder: (context, state) {
          if (state.loading) {
            return MyStyle.loadingWidget();
          }
          return BlocBuilder<GetMeCubit, GetMeInitial>(
            builder: (context, pState) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColorManager.whit,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
                ),
                padding: EdgeInsets.all(20.0).r,
                child: Column(
                  children: [
                    MyTextFormOutLineWidget(
                      enable: false,
                      label: S.of(context).closingAccountDate,
                      initialValue: pState.result.expiryDate?.formatDate,
                    ),
                    MyTextFormOutLineWidget(
                      enable: false,
                      initialValue: pState.result.name,
                      label: S.of(context).userName,
                    ),
                    MyTextFormOutLineWidget(
                        enable: false, initialValue: pState.result.phone, label: S.of(context).phoneNumber),
                    SpinnerWidget(
                      hintLabel: S.of(context).readPower,
                      hintText: S.of(context).readPower,
                      items: powerList
                          .map(
                            (e) => SpinnerItem(id: e, name: e.toString(), isSelected: state.power == e),
                          )
                          .toList(),
                      onChanged: (spinnerItem) {
                        context.read<ScanCubit>().setPower(spinnerItem.id);
                      },
                    ),
                    20.0.verticalSpace,
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: MyTextFormOutLineWidget(
                    //         enable: false,
                    //         initialValue: state.power.toString(),
                    //         label: S.of(context).readPower,
                    //       ),
                    //     ),
                    //     // 15.0.horizontalSpace,
                    //     // Expanded(
                    //     //   child: MyTextFormOutLineWidget(enable: false, initialValue: '30', label: 'طاقة الجرد'),
                    //     // ),
                    //   ],
                    // ),
                    MyTextFormOutLineWidget(
                      enable: false,
                      label: S.of(context).permissions,
                      iconWidgetLift: Column(
                        children: [
                          20.0.verticalSpace,
                          ListTile(
                            title: DrawableText(text: S.of(context).entity),
                            trailing: DrawableText(text: pState.result.entity.name),
                          ),
                          ListTile(
                            title: DrawableText(text: S.of(context).department),
                            trailing: DrawableText(text: pState.result.departmen.name),
                          ),
                          ListTile(
                            title: DrawableText(text: S.of(context).division),
                            trailing: DrawableText(text: pState.result.division.name),
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
        ImageMultiType(url: Assets.imagesBandtechCircle, height: 35.0.r, width: 35.0.r),
        DrawableText(text: S.of(context).bandtech, size: 24.0.sp, fontFamily: FontManager.bold.name),
        DrawableText(
          text: S.of(context).designProgrammingPropertyRightsAndPublishing,
          fontFamily: FontManager.bold.name,
        ),
        DrawableText(
          text: AppInfoService.fullVersionName,
          fontFamily: FontManager.bold.name,
        ),
      ],
    );
  }
}
