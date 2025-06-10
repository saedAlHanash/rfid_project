import 'package:drawable_text/drawable_text.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/features/auth/ui/widget/auth_card_image.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';
import '../../../notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../../profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../bloc/login_cubit/login_cubit.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginCubit get loginCubit => context.read<LoginCubit>();

  final _formKey = GlobalKey<FormState>();

  void updateData() {
    context.read<GetMeCubit>().getData(newData: true);
    context.read<NotificationCubit>().getData(newData: true);

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            updateData();
             context.goNamed( , RouteName.home);
          },
        ),

      ],
      child: Scaffold(
        body: SingleChildScrollView(
          // padding: MyStyle.authPagesPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthCardImage(
                  titleText: S.of(context).login,
                  description: S.of(context).signInToContinue,
                ),
                AutofillGroup(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                    child: Column(
                      children: [
                        20.0.verticalSpace,
                        MyTextFormOutLineWidget(
                          autofillHints: const [
                            AutofillHints.username,
                            AutofillHints.email,
                          ],
                          helperText: S.of(context).phoneNumberMustStartWith07,
                          // iconWidgetLift: ImageMultiType(
                          //   url: Assets.imagesIraqCode,
                          //   width: 70.0.w,
                          // ),
                          validator: (p0) => loginCubit.validatePhone,
                          labelText: S.of(context).phoneNumber,
                          hint: S.of(context).phoneNumber,
                          initialValue: loginCubit.state.request.phone,
                          keyBordType: TextInputType.phone,
                          icon: Assets.iconsCall,
                          maxLength: 12,
                          onChanged: (val) => loginCubit.setPhone = val,
                        ),
                        15.0.verticalSpace,
                        MyTextFormOutLineWidget(
                          autofillHints: const [AutofillHints.password],
                          validator: (p0) => loginCubit.validatePassword,
                          labelText: S.of(context).password,
                          hint: S.of(context).password,
                          icon: Assets.iconsKey,
                          obscureText: true,
                          initialValue: loginCubit.state.request.password,
                          onChanged: (val) => loginCubit.setPassword = val,
                        ),
                      ],
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.forgetPassword,
                      arguments: loginCubit.state.request.phone,
                    );
                  },
                  child: DrawableText(
                    text: S.of(context).forgetPassword,
                    matchParent: true,
                    fontFamily: FontManager.bold.name,
                    color: AppColorManager.mainColorLight,
                  ),
                ),
                10.0.verticalSpace,
                BlocBuilder<LoginCubit, LoginInitial>(
                  builder: (_, state) {
                    if (state.loading) {
                      return MyStyle.loadingWidget();
                    }
                    return MyButton(
                      text: S.of(context).login,
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) return;
                        TextInput.finishAutofillContext();
                        loginCubit.login();
                      },
                    );
                  },
                ),

                18.0.verticalSpace,
                DrawableText(
                  text: S.of(context).doNotHaveAnAccount,
                  drawableEnd: TextButton(
                    onPressed: () => context.pushNamed( RouteName.signup),
                    child: DrawableText(
                      fontFamily: FontManager.bold.name,
                      text: S.of(context).createNewAccount,
                      color: AppColorManager.mainColorLight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgetAndRememberWidget extends StatefulWidget {
  const _ForgetAndRememberWidget();

  @override
  State<_ForgetAndRememberWidget> createState() => _ForgetAndRememberWidgetState();
}

class _ForgetAndRememberWidgetState extends State<_ForgetAndRememberWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DrawableText(
          text: S.of(context).rememberMe,
          drawableEnd: Checkbox(
            value: true,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
