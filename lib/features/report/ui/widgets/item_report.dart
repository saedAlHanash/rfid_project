import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/router/go_router.dart';

import '../../../../core/util/my_style.dart';
import '../../../../generated/l10n.dart';
import '../../data/response/report_response.dart';
import '../pages/report_scan.dart';

class ItemReport extends StatelessWidget {
  const ItemReport({super.key, required this.report});

  final Report report;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(RouteName.report, queryParameters: {'id': report.id.toString()});
      },
      child: Container(
        margin: const EdgeInsets.all(16.0).r,
        padding: const EdgeInsets.all(16.0).r,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DrawableText(
                  text: '${S.of(context).dateTime}:  ${report.createdAt}',
                  color: Colors.grey.shade700,
                  size: 10.0.sp,
                ),
                DrawableText(
                  text: '${S.of(context).totalTags}:  ${report.stats.labelsCount}',
                  color: Colors.grey.shade700,
                  size: 10.0.sp,
                ),
              ],
            ),
            16.0.verticalSpace,
            // Row of Chips
            Row(
              spacing: 8,
              children: [
                if (report.stats.newCount > 0)
                  Expanded(
                    child: StatusBox(
                      title: S.of(context).new1,
                      color: Colors.green,
                      count: report.stats.newCount.toString(),
                    ),
                  ),
                if (report.stats.foundCount > 0)
                  Expanded(
                    child: StatusBox(
                      title: S.of(context).found,
                      color: Colors.black45,
                      count: report.stats.foundCount.toString(),
                    ),
                  ),
                if (report.stats.damagedCount > 0)
                  Expanded(
                    child: StatusBox(
                      title: S.of(context).damaged,
                      color: Colors.red,
                      count: report.stats.damagedCount.toString(),
                    ),
                  ),
                if (report.stats.unknownCount > 0)
                  Expanded(
                    child: StatusBox(
                      title: S.of(context).unknown,
                      color: Colors.amber,
                      count: report.stats.unknownCount.toString(),
                    ),
                  ),
              ],
            ),
            16.0.verticalSpace,
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
                      text: report.room.division.department.entity.name,
                      color: Colors.grey,
                    ),
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    matchParent: true,
                    text: S.of(context).department,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      text: report.room.division.department.name,
                      color: Colors.grey,
                    ),
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    matchParent: true,
                    text: S.of(context).division,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      text: report.room.division.name,
                      color: Colors.grey,
                    ),
                  ),
                  10.0.verticalSpace,
                  DrawableText(
                    matchParent: true,
                    text: S.of(context).room,
                    fontWeight: FontWeight.bold,
                    drawableEnd: DrawableText(
                      text: report.room.name,
                      color: Colors.grey,
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
