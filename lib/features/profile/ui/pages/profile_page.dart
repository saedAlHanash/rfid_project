import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/util/my_style.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/my_text_form_widget.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/strings/enum_manager.dart';
import '../../../../core/widgets/item_image_create.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/update_profile_cubit/update_profile_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AppProvider.getMe;

  UpdateProfileCubit get updateCubit => context.read<UpdateProfileCubit>();

  UpdateProfileInitial get updateState => context.read<UpdateProfileCubit>().state;

  final locationController = TextEditingController();
  final bDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    locationController.text = updateState.request.locationName ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateProfileCubit, UpdateProfileInitial>(
      listenWhen: (p, c) => c.statuses == CubitStatuses.done,
      listener: (context, state) => context.pop(, true),
      child: Scaffold(
        appBar: AppBarWidget(titleText: S.of(context).profile),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0).r,
          child: Form(
            key: _formKey,
            child: BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
              builder: (context, state) {
                locationController.text = updateState.request.locationName ?? '';


                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatefulBuilder(builder: (context, setState) {
                      return ItemImageCreate(
                        image: updateState.request.profileImageUrl.getImage,
                        onLoad: (bytes) {
                          setState(() =>
                              updateState.request.profileImageUrl.fileBytes = bytes);
                        },
                      );
                    }),
                    20.0.verticalSpace,
                    //name
                    MyTextFormOutLineWidget(
                      validator: (p0) => updateCubit.validateName,
                      controller: TextEditingController(text: updateState.request.name),
                      label: S.of(context).name,
                      onChanged: (val) => updateCubit.setName = val,
                    ),
                    if (!AppProvider.isStoreTest)
                      SpinnerWidget(
                        items: GenderEnum.values.getSpinnerItems(
                          selectedId: updateState.request.gender?.index,
                        ),
                        onChanged: (item) {
                          updateCubit.setGender = item.item;
                        },
                        hintText: '${S.of(context).choosing} ${S.of(context).gender}',
                      ),
                    // 20.0.verticalSpace,
                    // BlocBuilder<EducationalGradeCubit, EducationalGradeInitial>(
                    //   builder: (context, state) {
                    //     return SpinnerWidget(
                    //       items: state.getSpinnerItems(
                    //           selectedId:
                    //               updateState.request.educationalGradeId),
                    //       onChanged: (spinnerItem) {
                    //         updateCubit.setEducationalGrade = spinnerItem.id;
                    //       },
                    //       hintText:
                    //           '${S.of(context).choosing} ${S.of(context).educationalGrade}',
                    //     );
                    //   },
                    // ),
                    20.0.verticalSpace,
                    //birthdate
                    // MyTextFormOutLineWidget(
                    //   validator: (p0) => updateCubit.validateBirthday,
                    //   controller: bDateController,
                    //   enable: false,
                    //   label: S.of(context).birthday,
                    //   onTap: () async {
                    //     final datePicked = await showDatePicker(
                    //         context: context,
                    //         initialDate: updateState.request.birthday ?? DateTime(2000),
                    //         lastDate: DateTime.now(),
                    //         firstDate: DateTime(1900),
                    //         initialDatePickerMode: DatePickerMode.year,
                    //         initialEntryMode: DatePickerEntryMode.calendarOnly);
                    //     if (datePicked == null) return;
                    //     updateCubit.setBirthday = datePicked;
                    //     bDateController.text = datePicked.formatDate;
                    //   },
                    //   iconWidgetLift: const ImageMultiType(url: Icons.date_range),
                    // ),
                    //location
                    // MyTextFormOutLineWidget(
                    //   validator: (p0) => updateCubit.validateLocation,
                    //   controller: locationController,
                    //   label: S.of(context).location,
                    //   onChanged: (val) =>
                    //       updateCubit.setLocation(locationName: val),
                    //   iconWidgetLift: MyLocationWidget(
                    //     onDone: (state) {
                    //       locationController.text = state.locationName;
                    //       updateCubit.setLocation(
                    //         location: state.result,
                    //         locationName: state.locationName,
                    //       );
                    //     },
                    //   ),
                    // ),

                    BlocBuilder<UpdateProfileCubit, UpdateProfileInitial>(
                      builder: (context, state) {
                        if (state.loading) {
                          return MyStyle.loadingWidget();
                        }
                        return MyButton(
                          text: S.of(context).update,
                          onTap: () {
                            if (!_formKey.currentState!.validate()) return;
                            updateCubit.updateProfile();
                          },
                        );
                      },
                    ),
                    40.0.verticalSpace,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
