import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/util/snack_bar_message.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../department/bloc/departments_cubit/departments_cubit.dart';
import '../../../department/data/response/department_response.dart';
import '../../../division/bloc/divisions_cubit/divisions_cubit.dart';
import '../../../division/data/response/division_response.dart';
import '../../../entity/bloc/entities_cubit/entities_cubit.dart';
import '../../../room/bloc/rooms_cubit/rooms_cubit.dart';
import '../../../room/data/response/room_response.dart';
import '../../../asset/bloc/assets_cubit/assets_cubit.dart';
import '../../data/response/product_response.dart';

class MoveProductPage extends StatelessWidget {
  const MoveProductPage({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsCubit, AssetsInitial>(
          listenWhen: (p, c) => c.done && c.cubitCrud == CubitCrud.update,
          listener: (context, state) {
            context.pop();
            NoteMessage.showSuccessSnackBar(message: 'تم بنجاح', context: context);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).moveProduct,
        ),
        body: Column(
          children: [
            Container(
              decoration: MyStyle.outlineBorder,
              padding: EdgeInsets.all(16.0).r,
              margin: EdgeInsets.all(16.0).r,
              child: Column(
                children: [
                  DrawableText(
                    color: Colors.white,
                    matchParent: true,
                    text: S.of(context).tag,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      color: Colors.white,
                      text: product.label,
                    ),
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    color: Colors.white,
                    matchParent: true,
                    text: S.of(context).assetName,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      color: Colors.white,
                      text: product.asset.name,
                    ),
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    color: Colors.white,
                    matchParent: true,
                    text: S.of(context).assetStatus,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      color: Colors.white,
                      text: product.status,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0).r,
                decoration: BoxDecoration(
                  color: AppColorManager.whit,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(20.0.r)),
                ),
                child: BlocBuilder<AssetsCubit, AssetsInitial>(
                  builder: (context, cState) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        DrawableText(
                          text: 'From',
                          size: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                        ),
                        Container(
                          decoration: MyStyle.outlineBorder,
                          padding: EdgeInsets.all(16.0).r,
                          child: Column(
                            children: [
                              DrawableText(
                                matchParent: true,
                                text: S.of(context).entity,
                                fontWeight: FontWeight.bold,
                                drawableEnd: DrawableText(
                                  text: product.room.division.department.entity.name,
                                  color: Colors.grey,
                                ),
                              ),
                              10.0.verticalSpace,
                              DrawableText(
                                matchParent: true,
                                text: S.of(context).department,
                                fontWeight: FontWeight.bold,
                                drawableEnd: DrawableText(
                                  text: product.room.division.department.name,
                                  color: Colors.grey,
                                ),
                              ),
                              10.0.verticalSpace,
                              DrawableText(
                                matchParent: true,
                                text: S.of(context).division,
                                fontWeight: FontWeight.bold,
                                drawableEnd: DrawableText(
                                  text: product.room.division.name,
                                  color: Colors.grey,
                                ),
                              ),
                              10.0.verticalSpace,
                              DrawableText(
                                matchParent: true,
                                text: S.of(context).room,
                                fontWeight: FontWeight.bold,
                                drawableEnd: DrawableText(
                                  text: product.room.name,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        DrawableText(
                          text: 'To',
                          size: 20.0.sp,
                          fontWeight: FontWeight.bold,
                          padding: EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        BlocBuilder<EntitiesCubit, EntitiesInitial>(
                          builder: (context, state) {
                            return SpinnerWidget(
                              onChanged: (spinnerItem) {
                                cState.cRequest.entity = spinnerItem.item;

                                cState.cRequest.department = Department.fromJson({});
                                context.read<DepartmentsCubit>().clear();
                                cState.cRequest.division = Division.fromJson({});
                                context.read<DivisionsCubit>().clear();
                                cState.cRequest.room = Room.fromJson({});
                                context.read<RoomsCubit>().clear();

                                context
                                    .read<DepartmentsCubit>()
                                    .getData(id: spinnerItem.id);
                              },
                              loading: state.loading,
                              items: state.getSpinnerItems(
                                  selectedId: cState.cRequest.entity.id),
                              hintText: S.of(context).department,
                              hintLabel: S.of(context).entity,
                            );
                          },
                        ),
                        BlocBuilder<DepartmentsCubit, DepartmentsInitial>(
                          builder: (context, state) {
                            return SpinnerWidget(
                              onChanged: (spinnerItem) {
                                cState.cRequest.department = spinnerItem.item;

                                cState.cRequest.division = Division.fromJson({});
                                context.read<DivisionsCubit>().clear();
                                cState.cRequest.room = Room.fromJson({});
                                context.read<RoomsCubit>().clear();

                                context
                                    .read<DivisionsCubit>()
                                    .getData(id: spinnerItem.id);
                              },
                              loading: state.loading,
                              items: state.getSpinnerItems(
                                  selectedId: cState.cRequest.department.id),
                              hintText: S.of(context).department,
                              hintLabel: S.of(context).department,
                            );
                          },
                        ),
                        BlocBuilder<DivisionsCubit, DivisionsInitial>(
                          builder: (context, state) {
                            return SpinnerWidget(
                              onChanged: (spinnerItem) {
                                cState.cRequest.division = spinnerItem.item;

                                cState.cRequest.room = Room.fromJson({});
                                context.read<RoomsCubit>().clear();

                                context.read<RoomsCubit>().getData(id: spinnerItem.id);
                              },
                              loading: state.loading,
                              items: state.getSpinnerItems(
                                  selectedId: cState.cRequest.division.id),
                              hintText: S.of(context).division,
                              hintLabel: S.of(context).division,
                            );
                          },
                        ),
                        BlocBuilder<RoomsCubit, RoomsInitial>(
                          builder: (context, state) {
                            return SpinnerWidget(
                              onChanged: (spinnerItem) {
                                cState.cRequest.room = spinnerItem.item;
                              },
                              loading: state.loading,
                              items: state.getSpinnerItems(
                                  selectedId: cState.cRequest.room.id),
                              hintText: S.of(context).room,
                              hintLabel: S.of(context).room,
                            );
                          },
                        ),
                        30.0.verticalSpace,
                        MyButton(
                          onTap: () {
                            cState.cRequest.labels
                              ..clear()
                              ..add(cState.product.label);
                            context.read<AssetsCubit>().update(cState.product.id);
                          },
                          text: S.of(context).moveProduct,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
