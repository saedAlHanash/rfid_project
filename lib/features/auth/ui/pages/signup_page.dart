import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:rfid_project/core/widgets/spinner_widget.dart';
import 'package:rfid_project/features/auth/ui/widget/auth_card_image.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/signup_cubit/signup_cubit.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupCubit get signupCubit => context.read<SignupCubit>();

  SignupInitial get signupState => context.read<SignupCubit>().state;

  final locationController = TextEditingController();
  final bDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupInitial>(
      listenWhen: (p, c) => c.done,
      listener: (context, state) {
        context.goNamed(RouteName.confirmCode);
      },
      child: Scaffold(
        body: Column(
          children: [
            AuthCardImage(
              titleText: S.of(context).signUp,
              description: S.of(context).youMustEnterYourDataCorrectlyToAvoidProblemsAnd,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0).r,
                children: [
                  Form(
                    key: _formKey,
                    child: BlocBuilder<SignupCubit, SignupInitial>(
                      builder: (context, state) {
                        locationController.text = signupState.request.locationName ?? '';
                        bDateController.text = signupState.request.birthday?.formatDate ?? '';

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            20.verticalSpace,

                            //name
                            MyTextFormOutLineWidget(
                              icon: Assets.iconsUserName,
                              validator: (p0) => signupCubit.validateName,
                              initialValue: signupState.request.name,
                              labelText: S.of(context).fullName,
                              hint: S.of(context).fullName,
                              onChanged: (val) => signupCubit.setName = val,
                            ),

                            if (!AppProvider.isStoreTest) 10.0.verticalSpace,
                            if (!AppProvider.isStoreTest)
                              SpinnerWidget(
                                icon: Assets.iconsUserName,
                                items: GenderEnum.values.getSpinnerItems(
                                  selectedId: signupState.request.gender?.index,
                                ),
                                onChanged: (item) => signupCubit.setGender = item.item,
                                hintText: '${S.of(context).choosing} ${S.of(context).gender}',
                                hintLabel: '${S.of(context).choosing} ${S.of(context).gender}',
                              ),
                            20.0.verticalSpace,

                            DrawableText(
                              text: S.of(context).youCanChangeYourStudyLevelLater,
                              color: Colors.grey,
                              padding: EdgeInsets.symmetric(horizontal: 10.0).r,
                              size: 12.0.sp,
                            ),
                            20.0.verticalSpace,
                            //birthdate
                            if (!AppProvider.isStoreTest)
                              MyTextFormOutLineWidget(
                                validator: (p0) => signupCubit.validateBirthday,
                                controller: bDateController,
                                enable: false,
                                labelText: S.of(context).birthday,
                                hint: S.of(context).birthday,
                                onTap: () async {
                                  final datePicked = await showDatePicker(
                                    context: context,
                                    initialDate: signupState.request.birthday ?? DateTime(2000),
                                    lastDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                  );

                                  if (datePicked == null) return;
                                  signupCubit.setBirthday = datePicked;
                                  bDateController.text = datePicked.formatDate;
                                },
                                icon: const ImageMultiType(url: Assets.iconsCalendar),
                              ),
                            // رقم الهاتف
                            MyTextFormOutLineWidget(
                              validator: (p0) => signupCubit.validatePhone,
                              initialValue: signupState.request.phone,
                              keyBordType: TextInputType.phone,
                              maxLength: 12,
                              icon: ImageMultiType(url: Assets.iconsPhone),
                              labelText: S.of(context).phoneNumber,
                              hint: S.of(context).phoneNumberMustStartWith07,
                              onChanged: (val) => signupCubit.setPhone = val,
                            ),
                            // كلمة السر
                            MyTextFormOutLineWidget(
                              icon: Assets.iconsKey,
                              validator: (p0) => signupCubit.validatePassword,
                              labelText: S.of(context).password,
                              hint: S.of(context).password,
                              initialValue: signupState.request.password,
                              obscureText: true,
                              onChanged: (val) => signupCubit.setPassword = val,
                              textDirection: TextDirection.ltr,
                            ),
                            // كلمة السر
                            MyTextFormOutLineWidget(
                              icon: Assets.iconsKey,
                              validator: (p0) => signupCubit.validateRePassword,
                              labelText: S.of(context).rePassword,
                              hint: S.of(context).rePassword,
                              obscureText: true,
                              initialValue: signupState.request.rePassword,
                              onChanged: (val) => signupCubit.setRePassword = val,
                              textDirection: TextDirection.ltr,
                            ),

                            10.0.verticalSpace,
                            BlocBuilder<SignupCubit, SignupInitial>(
                              builder: (context, state) {
                                return MyButton(
                                  loading: state.loading,
                                  text: S.of(context).signUp,
                                  onTap: () {
                                    if (!_formKey.currentState!.validate()) return;
                                    signupCubit.signup();
                                  },
                                  // context.pushNamed( RouteName.secSign);                          },
                                );
                              },
                            ),
                            40.0.verticalSpace,
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
