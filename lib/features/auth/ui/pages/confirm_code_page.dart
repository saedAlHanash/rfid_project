import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/util/snack_bar_message.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/features/auth/ui/widget/auth_card_image.dart';
import 'package:rfid_project/features/auth/ui/widget/remember_account.dart';
import 'package:rfid_project/features/auth/ui/widget/resend_btn.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/util/shared_preferences.dart';
import '../../../../core/widgets/verification_code_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';
import '../../bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../../bloc/resend_code_cubit/resend_code_cubit.dart';

class ConfirmCodePage extends StatefulWidget {
  const ConfirmCodePage({super.key});

  @override
  State<ConfirmCodePage> createState() => _ConfirmCodePageState();
}

class _ConfirmCodePageState extends State<ConfirmCodePage> {
  late final ConfirmCodeCubit confirmCodeCubit;
  late final ResendCodeCubit resendCodeCubit;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    confirmCodeCubit = context.read<ConfirmCodeCubit>();
    resendCodeCubit = context.read<ResendCodeCubit>();
    confirmCodeCubit.setPhone = AppSharedPreference.getPhone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ConfirmCodeCubit, ConfirmCodeInitial>(
          listenWhen: (p, current) => current.statuses == CubitStatuses.done,
          listener: (context, state) {

          },
        ),
        BlocListener<ResendCodeCubit, ResendCodeInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            NoteMessage.showAwesomeDoneDialog(
              context,
              message: state.error.isEmpty
                  ? '${S.of(context).done_resend_code} ${state.result}'
                  : state.error,
            );
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          children: [
            AuthCardImage(
              titleText: S.of(context).enterOTP,
              description:
                  '${S.of(context).enterTheVerificationCodeWeJustSentToYourNumber} ${AppSharedPreference.getPhone}',
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: MyStyle.authPagesPadding,
                children: [
                  40.0.verticalSpace,
                  Form(
                    key: _formKey,
                    child: PinCodeWidget(
                      onChange: (p0) => setState(() => confirmCodeCubit.setCode = p0),
                      validator: (p0) => confirmCodeCubit.validateCode,
                    ),
                  ),
                  20.0.verticalSpace,
                  ResendBtn(),
                  20.0.verticalSpace,
                  BlocBuilder<ConfirmCodeCubit, ConfirmCodeInitial>(
                    builder: (context, state) {
                      if (state.loading) {
                        return MyStyle.loadingWidget();
                      }
                      return MyButton(
                        enable: state.canSend,
                        text: S.of(context).sendCode,
                        onTap: () {
                          if (AppSharedPreference.getPhone.isEmpty) {
                            context.pushReplacementNamed( RouteName.login);
                            return;
                          }
                          if (!_formKey.currentState!.validate()) return;
                          confirmCodeCubit.confirmCode();
                        },
                      );
                    },
                  ),
                  20.0.verticalSpace,
                  RememberAccount(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
