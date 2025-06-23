import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/widgets/my_button.dart';
import 'package:rfid_project/core/widgets/spinner_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../../router/go_router.dart';
import '../../../department/bloc/departments_cubit/departments_cubit.dart';
import '../../../division/bloc/divisions_cubit/divisions_cubit.dart';
import '../../../entity/bloc/entities_cubit/entities_cubit.dart';
import '../../../room/bloc/rooms_cubit/rooms_cubit.dart';
import '../../bloc/assets_cubit/assets_cubit.dart';

class AddAssetPage extends StatelessWidget {
  const AddAssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AssetsCubit, AssetsInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).addProduct,
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
                  context.read<AssetsCubit>().getData(newData: true);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          BlocBuilder<AssetsCubit, AssetsInitial>(
                            builder: (context, state) {
                              return SpinnerWidget(
                                onChanged: (spinnerItem) {
                                  cState.cRequest.asset = spinnerItem.item;
                                },
                                loading: state.loading,
                                searchable: true,
                                items: state.getSpinnerItems(selectedId: cState.cRequest.asset.id),
                                hintText: S.of(context).assetName,
                                hintLabel: S.of(context).assetName,
                              );
                            },
                          ),
                          BlocBuilder<EntitiesCubit, EntitiesInitial>(
                            builder: (context, state) {
                              return SpinnerWidget(
                                onChanged: (spinnerItem) {
                                  cState.cRequest.entity = spinnerItem.item;
                                  context.read<DepartmentsCubit>().getData(id: spinnerItem.id);
                                },
                                loading: state.loading,
                                items: state.getSpinnerItems(selectedId: cState.cRequest.entity.id),
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
                                  context.read<DivisionsCubit>().getData(id: spinnerItem.id);
                                },
                                loading: state.loading,
                                items: state.getSpinnerItems(selectedId: cState.cRequest.department.id),
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
                                  context.read<RoomsCubit>().getData(id: spinnerItem.id);
                                },
                                loading: state.loading,
                                items: state.getSpinnerItems(selectedId: cState.cRequest.division.id),
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
                                items: state.getSpinnerItems(selectedId: cState.cRequest.room.id),
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
                        context.pushNamed(RouteName.assets);
                      },
                      text: S.of(context).next,
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
