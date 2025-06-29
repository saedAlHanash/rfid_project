import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/features/asset/data/request/create_asset_request.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../department/bloc/departments_cubit/departments_cubit.dart';
import '../../../division/bloc/divisions_cubit/divisions_cubit.dart';
import '../../../entity/bloc/entities_cubit/entities_cubit.dart';
import '../../../room/bloc/rooms_cubit/rooms_cubit.dart';
import '../../bloc/reports_cubit/reports_cubit.dart';

class FindRoom extends StatefulWidget {
  const FindRoom({super.key});

  @override
  State<FindRoom> createState() => _FindRoomState();
}

class _FindRoomState extends State<FindRoom> {
  final request = CreateAssetRequest.fromJson({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.mainColor,
      appBar: AppBarWidget(
        titleText: S.of(context).assetsScan,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0).r,
        decoration: BoxDecoration(
          color: AppColorManager.whit,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  BlocBuilder<EntitiesCubit, EntitiesInitial>(
                    builder: (context, state) {
                      return SpinnerWidget(
                        onChanged: (spinnerItem) {
                          request.entity = spinnerItem.item;
                          context.read<DepartmentsCubit>().getData(id: spinnerItem.id);
                        },
                        loading: state.loading,
                        items: state.getSpinnerItems(),
                        hintText: S.of(context).department,
                        hintLabel: S.of(context).entity,
                      );
                    },
                  ),
                  BlocBuilder<DepartmentsCubit, DepartmentsInitial>(
                    builder: (context, state) {
                      return SpinnerWidget(
                        onChanged: (spinnerItem) {
                          request.department = spinnerItem.item;
                          context.read<DivisionsCubit>().getData(id: spinnerItem.id);
                        },
                        loading: state.loading,
                        items: state.getSpinnerItems(),
                        hintText: S.of(context).department,
                        hintLabel: S.of(context).department,
                      );
                    },
                  ),
                  BlocBuilder<DivisionsCubit, DivisionsInitial>(
                    builder: (context, state) {
                      return SpinnerWidget(
                        onChanged: (spinnerItem) {
                          request.division = spinnerItem.item;
                          context.read<RoomsCubit>().getData(id: spinnerItem.id);
                        },
                        loading: state.loading,
                        items: state.getSpinnerItems(),
                        hintText: S.of(context).division,
                        hintLabel: S.of(context).division,
                      );
                    },
                  ),
                  BlocBuilder<RoomsCubit, RoomsInitial>(
                    builder: (context, state) {
                      return SpinnerWidget(
                        onChanged: (spinnerItem) {
                          request.room = spinnerItem.item;
                        },
                        loading: state.loading,
                        items: state.getSpinnerItems(),
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
                context.pushReplacementNamed(RouteName.reportScan, extra: request);
              },
              text: S.of(context).next,
            ),
          ],
        ),
      ),
    );
  }
}
