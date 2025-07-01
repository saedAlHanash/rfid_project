import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/features/auth/ui/widget/auth_card_image.dart';

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
    // context.read<NotificationCubit>().getData(newData: true);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            updateData();
            context.goNamed(RouteName.home);
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBarWidget(zeroHeight: true, color: AppColorManager.mainColor),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              AuthCardImage(titleText: S.of(context).login, description: S.of(context).signInToContinue),
              AutofillGroup(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                  child: Column(
                    children: [
                      20.0.verticalSpace,
                      MyTextFormOutLineWidget(
                        autofillHints: const [AutofillHints.username, AutofillHints.email],
                        helperText: S.of(context).phoneNumberMustStartWith07,
                        validator: (p0) => loginCubit.validatePhone,
                        labelText: S.of(context).phoneNumber,
                        hint: S.of(context).phoneNumber,
                        initialValue: loginCubit.state.request.phone,
                        keyBordType: TextInputType.phone,
                        maxLength: 12,
                        onChanged: (val) => loginCubit.setPhone = val,
                      ),
                      15.0.verticalSpace,
                      MyTextFormOutLineWidget(
                        autofillHints: const [AutofillHints.password],
                        validator: (p0) => loginCubit.validatePassword,
                        labelText: S.of(context).password,
                        hint: S.of(context).password,
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
                  return MyButton(
                    loading: state.loading,
                    text: S.of(context).login,
                    margin: EdgeInsets.symmetric(horizontal: 20.0).r,
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) return;
                      TextInput.finishAutofillContext();
                      loginCubit.login();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
