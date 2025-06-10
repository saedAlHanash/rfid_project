import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/features/auth/data/request/resend_request.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ResendBtn extends StatefulWidget {
  const ResendBtn({super.key});

  @override
  State<ResendBtn> createState() => _ResendBtnState();
}

class _ResendBtnState extends State<ResendBtn> {
  Timer? timer;

  var countRemaining = 0;

  void showSendMethodBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).chooseHowToReceiveYour2stepCode,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              ListTile(
                leading: ImageMultiType(
                  url: Icons.sms,
                  color: AppColorManager.mainColor,
                ),
                title: Text(S.of(context).sendViaSms),
                onTap: () {
                  context.pop(); // إغلاق الـ BottomSheet
                  _handleSendMethod(ResendCodeType.sms);
                },
              ),
              ListTile(
                leading: ImageMultiType(
                  url: Assets.iconsWhatsapp,
                  color: AppColorManager.mainColor,
                ),
                title: Text(S.of(context).sendViaWhatsapp),
                onTap: () {
                  context.pop(); // إغلاق الـ BottomSheet
                  _handleSendMethod(ResendCodeType.whatsapp);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleSendMethod(ResendCodeType method) {
    if (AppSharedPreference.getPhone.isEmpty) {
      context.pushReplacementNamed( RouteName.login);
      return;
    }
    context.read<ResendCodeCubit>().resendCode(request: ResendRequest(type: method));
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (countRemaining <= 0) {
          setState(() => timer.cancel());
          return;
        }
        setState(() => countRemaining--);
      },
    );
  }

  @override
  void initState() {
    countRemaining = AppProvider.getRemaining;
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<ResendCodeCubit, ResendCodeInitial>(
        listenWhen: (p, c) => c.done,
        listener: (context, state) {
          countRemaining = AppProvider.getRemaining;
          if (countRemaining <= 0) {
            setState(() {});
            return;
          }
          timer?.cancel();
          startTimer();
        },
        builder: (context, state) {
          if (state.loading) {
            return MyStyle.loadingWidget();
          }
          return countRemaining > 0
              ? DrawableText(
                  matchParent: true,
                  textAlign: TextAlign.center,
                  text: countRemaining.toString(),
                  size: 24.0.sp,
                )
              : DrawableText(
                  text: S.of(context).didntReceiveTheCode,
                  color: AppColorManager.gray,
                  drawablePadding: 10.0.w,
                  drawableEnd: InkWell(
                    onTap: () => showSendMethodBottomSheet(context),
                    child: DrawableText(
                      text: S.of(context).resend,
                      fontFamily: FontManager.bold.name,
                      color: AppColorManager.mainColor,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
