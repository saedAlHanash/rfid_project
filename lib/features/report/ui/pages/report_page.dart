import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rfid_project/features/report/ui/pages/report_scan.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/report_cubit/report_cubit.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.mainColor,
      appBar: AppBarWidget(
        titleText: S.of(context).report,
      ),
      body: BlocBuilder<ReportCubit, ReportInitial>(
        builder: (context, state) {
          return Container(
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
                          text: state.result.room.division.department.entity.name,
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
                          text: state.result.room.division.department.name,
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
                          text: state.result.room.division.name,
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
                          text: state.result.room.name,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                20.0.verticalSpace,
                Row(
                  spacing: 8,
                  children: [
                    if (state.result.stats.newCount > 0)
                      Expanded(
                        child: StatusBox(
                          title: 'new:',
                          color: Colors.green,
                          count: state.result.stats.newCount.toString(),
                        ),
                      ),
                    if (state.result.stats.foundCount > 0)
                      Expanded(
                        child: StatusBox(
                          title: 'found:',
                          color: Colors.black45,
                          count: state.result.stats.foundCount.toString(),
                        ),
                      ),
                    if (state.result.stats.damagedCount > 0)
                      Expanded(
                        child: StatusBox(
                          title: 'damaged:',
                          color: Colors.red,
                          count: state.result.stats.damagedCount.toString(),
                        ),
                      ),
                    if (state.result.stats.unknownCount > 0)
                      Expanded(
                        child: StatusBox(
                          title: 'unknown:',
                          color: Colors.amber,
                          count: state.result.stats.unknownCount.toString(),
                        ),
                      ),
                  ],
                ),
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
                if (state.result.itemsDetails.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.result.itemsDetails.length,
                      itemBuilder: (context, i) {
                        final e = state.result.itemsDetails[i];
                        return TableItem(
                          e: [
                            e.label,
                            e.status,
                            e.assetName,
                            (i + 1).toString(),
                          ],
                        );
                      },
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
