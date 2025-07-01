import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';

import '../../../../core/widgets/app_bar/app_bar_widget.dart';
import '../../../../core/widgets/refresh_widget/refresh_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/reports_cubit/reports_cubit.dart';
import '../widgets/item_report.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorManager.lightGray,
      appBar: AppBarWidget(
        titleText: S.of(context).reports,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.filter_alt_outlined,
              color: AppColorManager.whit,
            ),
            onPressed: () async {
              final result = await showDialog<DateRange?>(
                context: context,
                builder: (_) => const _DateFilterDialog(),
              );

              if (result != null && context.mounted) {
                context.read<ReportsCubit>().getData(request: result);
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<ReportsCubit, ReportsInitial>(
        builder: (context, state) {
          return RefreshWidget(
            isLoading: state.loading,
            onRefresh: () => context.read<ReportsCubit>().getData(newData: true),
            child: ListView.separated(
              itemCount: state.result.length,
              separatorBuilder: (_, i) => 10.0.verticalSpace,
              itemBuilder: (_, i) {
                final item = state.result[i];
                return ItemReport(report: item);
              },
            ),
          );
        },
      ),
    );
  }
}

class _DateFilterDialog extends StatefulWidget {
  const _DateFilterDialog();

  @override
  State<_DateFilterDialog> createState() => _DateFilterDialogState();
}

class _DateFilterDialogState extends State<_DateFilterDialog> {
  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDate({required bool isFrom}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 1),
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const DrawableText(text: 'فلترة بالتاريخ'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: DrawableText(
                text: fromDate != null
                    ? 'من: ${fromDate!.toLocal().toString().split(' ')[0]}'
                    : 'اختر تاريخ البدء'),
            trailing: const Icon(Icons.date_range),
            onTap: () => _selectDate(isFrom: true),
          ),
          ListTile(
            title: DrawableText(
                text: toDate != null
                    ? 'إلى: ${toDate!.toLocal().toString().split(' ')[0]}'
                    : 'اختر تاريخ الانتهاء'),
            trailing: const Icon(Icons.date_range),
            onTap: () => _selectDate(isFrom: false),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const DrawableText(text: 'إلغاء'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, DateRange(from: fromDate, to: toDate));
          },
          child: const DrawableText(text: 'تطبيق'),
        ),
      ],
    );
  }
}

class DateRange {
  final DateTime? from;
  final DateTime? to;

  DateRange({this.from, this.to});

  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(
      from: json['from'] != null ? DateTime.parse(json['from']) : null,
      to: json['to'] != null ? DateTime.parse(json['to']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from?.toIso8601String(),
      'to': to?.toIso8601String(),
    };
  }
}
