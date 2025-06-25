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
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_text_form_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../department/bloc/departments_cubit/departments_cubit.dart';
import '../../../department/data/response/department_response.dart';
import '../../../division/bloc/divisions_cubit/divisions_cubit.dart';
import '../../../division/data/response/division_response.dart';
import '../../../entity/bloc/entities_cubit/entities_cubit.dart';
import '../../../entity/data/response/entity_response.dart';
import '../../../room/bloc/rooms_cubit/rooms_cubit.dart';
import '../../../room/data/response/room_response.dart';
import '../../../asset/bloc/assets_cubit/assets_cubit.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({super.key});

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late AssetsInitial cState;
  late AssetsCubit cCubit;
  late DepartmentsCubit dCubit;
  late DivisionsCubit diCubit;
  late RoomsCubit riCubit;

  @override
  void initState() {
    cCubit = context.read<AssetsCubit>();
    cState = cCubit.state;
    dCubit = context.read<DepartmentsCubit>();
    diCubit = context.read<DivisionsCubit>();
    riCubit = context.read<RoomsCubit>();
    super.initState();
  }

  void setEntity(Entity entity) {
    cState.cRequest.entity = entity;

    cState.cRequest.department = Department.fromJson({});
    dCubit.clear();
    cState.cRequest.division = Division.fromJson({});
    diCubit.clear();
    cState.cRequest.room = Room.fromJson({});
    riCubit.clear();

    dCubit.getData(id: entity.id);
  }

  void setDepartment(Department department) {
    cState.cRequest.department = department;
    cState.cRequest.division = Division.fromJson({});
    diCubit.clear();
    cState.cRequest.room = Room.fromJson({});
    riCubit.clear();
    diCubit.getData(id: department.id);
  }

  void setDivision(Division division) {
    cState.cRequest.division = division;

    cState.cRequest.room = Room.fromJson({});
    riCubit.clear();

    riCubit.getData(id: division.id);
  }

  void setRoom(Room room) {
    cState.cRequest.room = room;
  }

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
          titleText: S.of(context).editProduct,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0).r,
          decoration: BoxDecoration(
            color: AppColorManager.whit,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
          ),
          child: BlocBuilder<AssetsCubit, AssetsInitial>(
            builder: (context, cState) {
              return RefreshWidget(
                isLoading: cState.loading,
                onRefresh: () {
                  cCubit.getData(newData: true);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          MyTextFormOutLineWidget(
                            initialValue: cState.product.label,
                            label: 'رقم الملصق',
                            onChanged: (p0) {
                              cState.product.label = p0;
                            },
                          ),
                          DrawableText(
                            text: 'حالة الأصل ',
                            matchParent: true,
                            size: 18.0.sp,
                            drawableEnd: DrawableText(
                              text: cState.product.status,
                            ),
                          ),
                          20.0.verticalSpace,
                          BlocBuilder<AssetsCubit, AssetsInitial>(
                            builder: (context, state) {
                              return SpinnerWidget(
                                onChanged: (spinnerItem) {
                                  cState.cRequest.asset = spinnerItem.item;
                                },
                                loading: state.loading,
                                searchable: true,
                                items: state.getSpinnerItems(
                                    selectedId: cState.cRequest.asset.id),
                                hintText: S.of(context).assetName,
                                hintLabel: S.of(context).assetName,
                              );
                            },
                          ),
                          BlocBuilder<EntitiesCubit, EntitiesInitial>(
                            builder: (context, state) {
                              return SpinnerWidget(
                                onChanged: (spinnerItem) {
                                  setEntity(spinnerItem.item);
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
                                  setDepartment(spinnerItem.item);
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
                                  setDivision(spinnerItem.item);
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
                                  setRoom(spinnerItem.item);
                                },
                                loading: state.loading,
                                items: state.getSpinnerItems(
                                    selectedId: cState.cRequest.room.id),
                                hintText: S.of(context).room,
                                hintLabel: S.of(context).room,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    MyButton(
                      onTap: () {
                        cState.cRequest.labels
                          ..clear()
                          ..add(cState.product.label);
                        cCubit.update(cState.product.id);
                      },
                      text: S.of(context).editProduct,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
