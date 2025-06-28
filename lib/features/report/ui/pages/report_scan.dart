import 'dart:async';

import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/widgets/my_button.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/util/snack_bar_message.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';
import '../../../asset/data/request/create_asset_request.dart';
import '../../../database/ui/widgets/scan_buttons.dart';
import '../../../scan/bloc/scan_cubit/scan_cubit.dart';
import '../../bloc/report_scan_cubit/report_scan_cubit.dart';
import '../../bloc/reports_cubit/reports_cubit.dart';

class ReportScan extends StatefulWidget {
  const ReportScan({super.key, required this.request});

  final CreateAssetRequest request;

  @override
  State<ReportScan> createState() => _ReportScanState();
}

class _ReportScanState extends State<ReportScan> {
  late final ScanCubit cubit;

  Timer? t;

  @override
  void initState() {
    cubit = context.read<ScanCubit>();

    t = Timer.periodic(
      Duration(seconds: 2),
      (timer) => cubit
        ..getStatus()
        ..getData(),
    );

    cubit.init();
    super.initState();
  }

  @override
  void dispose() {
    cubit.dispose();
    t?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ReportsCubit, ReportsInitial>(
          listenWhen: (p, c) => c.done && c.cubitCrud == CubitCrud.create,
          listener: (context, state) {
            context.pop();
            NoteMessage.showSuccessSnackBar(message: 'تم بنجاح', context: context);
          },
        ),
        BlocListener<ScanCubit, ScanInitial>(
          listenWhen: (p, c) => c.done,
          listener: (context, state) {
            context.read<ReportScanCubit>().calculate(state.result);
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorManager.mainColor,
        appBar: AppBarWidget(
          titleText: S.of(context).assetsScan,
        ),
        body: Container(
          padding: EdgeInsets.all(15.0).r,
          decoration: BoxDecoration(
            color: AppColorManager.whit,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
          ),
          child: Column(
            children: [
              Container(
                decoration: MyStyle.outlineBorder,
                padding: EdgeInsets.all(15).r,
                child: Column(
                  children: [
                    DrawableText(
                      size: 10.0,
                      matchParent: true,
                      text: S.of(context).entity,
                      fontWeight: FontWeight.bold,
                      drawableEnd: DrawableText(
                        size: 10.0,
                        text: widget.request.entity.name,
                        color: Colors.grey,
                      ),
                    ),
                    10.0.verticalSpace,
                    DrawableText(
                      size: 10.0,
                      matchParent: true,
                      text: S.of(context).department,
                      fontWeight: FontWeight.bold,
                      drawableEnd: DrawableText(
                        size: 10.0,
                        text: widget.request.department.name,
                        color: Colors.grey,
                      ),
                    ),
                    10.0.verticalSpace,
                    DrawableText(
                      size: 10.0,
                      matchParent: true,
                      text: S.of(context).division,
                      fontWeight: FontWeight.bold,
                      drawableEnd: DrawableText(
                        size: 10.0,
                        text: widget.request.division.name,
                        color: Colors.grey,
                      ),
                    ),
                    10.0.verticalSpace,
                    DrawableText(
                      size: 10.0,
                      matchParent: true,
                      text: S.of(context).room,
                      fontWeight: FontWeight.bold,
                      drawableEnd: DrawableText(
                        size: 10.0,
                        text: widget.request.room.name,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<ReportScanCubit, ReportScanInitial>(
                builder: (context, state) {
                  if (state.loading) {
                    return MyStyle.loadingWidget();
                  }
                  return Column(
                    children: [
                      20.0.verticalSpace,
                      AssetsSummaryWidget(),
                      20.0.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 2,
                            child: TableHeaderItem(title: S.of(context).assetStatus),
                          ),
                          15.0.horizontalSpace,
                          Expanded(
                            flex: 1,
                            child: TableHeaderItem(title: S.of(context).assetName),
                          ),
                          15.0.horizontalSpace,
                          Expanded(
                            flex: 1,
                            child: TableHeaderItem(title: S.of(context).tag),
                          ),
                        ],
                      ),
                      2.0.verticalSpace,
                      if (state.scannedInfo.isNotEmpty)
                        ...state.scannedInfo.map((e) => TableItem(e: e)),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: ScanButtons(
          save: BlocBuilder<ReportsCubit, ReportsInitial>(
            builder: (context, state) {
              return MyButton(
                loading: state.loading,
                elevation: 0.0,
                onTap: () {
                  context.read<ReportsCubit>()
                    ..state.cRequest.roomId = widget.request.room.id
                    ..state.cRequest.labels.clear()
                    ..state.cRequest.labels.addAll(context.read<ReportScanCubit>().state.allScanned)
                    ..create();
                },
                icon:
                    ImageMultiType(url: Assets.iconsFloppyDisk, height: 24.0, color: Colors.white),
                text: S.of(context).save,
              );
            },
          ),
        ),
      ),
    );
  }
}

class TableHeaderItem extends StatelessWidget {
  const TableHeaderItem({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: AppColorManager.mainColor,
        borderRadius: BorderRadius.circular(2.0.r),
      ),
      alignment: Alignment.center,
      child: DrawableText(
        text: title,
        size: 12.0.sp,
        color: Colors.white,
      ),
    );
  }
}

class TableItem extends StatelessWidget {
  const TableItem({required this.e});

  final List<dynamic> e;

  @override
  Widget build(BuildContext context) {
    if (e.length < 3) return 0.0.verticalSpace;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (e.length > 3) DrawableText(text: e[3]),
          Expanded(
              flex: 2,
              child: DrawableText(
                text: e[0],
                size: 9.0.sp,
                matchParent: true,
                textAlign: TextAlign.center,
              )),
          15.0.horizontalSpace,
          Expanded(
              flex: 1,
              child: DrawableText(
                text: e.last.toString(),
                size: 10.0.sp,
                matchParent: true,
                textAlign: TextAlign.center,
              )),
          15.0.horizontalSpace,
          Expanded(
            flex: 1,
            child: (e[1] is TagStatus)
                ? (e[1] as TagStatus).getWidget
                : (e[1] is AssetStatus)
                    ? (e[1] as AssetStatus).getWidget
                    : DrawableText(text: e[1].toString()),
          ),
        ],
      ),
    );
  }
}

class AssetsSummaryWidget extends StatelessWidget {
  const AssetsSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportScanCubit, ReportScanInitial>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawableText(
                text: '${S.of(context).totalAssets}: ${state.result.length}',
                size: 18,
                fontWeight: FontWeight.bold),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatusBox(
                  title: S.of(context).match,
                  count: state.match.length.toString(),
                  color: Colors.green,
                ),
                StatusBox(
                  title: S.of(context).missing,
                  count: state.missing.length.toString(),
                  color: Colors.red,
                ),
                StatusBox(
                  title: S.of(context).unsigned,
                  count: state.unsigned.length.toString(),
                  color: Colors.black,
                ),
                StatusBox(
                  title: S.of(context).unknown,
                  count: state.unknown.length.toString(),
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class StatusBox extends StatelessWidget {
  const StatusBox({
    super.key,
    this.title,
    required this.count,
    required this.color,
    this.status,
  });

  final String? title;
  final String count;
  final Color color;
  final TagStatus? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color),
      ),
      child: status != null
          ? DrawableText(
              text: count,
              color: color,
              fontWeight: FontWeight.bold,
              drawableEnd: status!.getWidget,
            )
          : DrawableText(
              text: '$title : $count',
              color: color,
              textAlign: TextAlign.center,
              size: 10.0.sp,
              fontWeight: FontWeight.bold,
            ),
    );
  }
}
