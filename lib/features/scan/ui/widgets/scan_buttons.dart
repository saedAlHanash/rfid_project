import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/features/scan/bloc/scan_cubit/scan_cubit.dart';

import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/l10n.dart';

class ScanButtons extends StatelessWidget {
  const ScanButtons({super.key, this.search, this.save});

  final Widget? search;
  final Widget? save;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanCubit, ScanInitial>(
      builder: (context, state) {
        if (state.loading) {
          return MyStyle.loadingWidget();
        }
        return Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (save != null) Expanded(flex: 5, child: save!),
                  if (save != null) 15.0.horizontalSpace,
                  Expanded(
                    flex: 5,
                    child: MyButton(
                      elevation: 0.0,
                      onTap: () {
                        context.read<ScanCubit>().clear();
                      },
                      icon: ImageMultiType(
                          url: Assets.iconsTrash, height: 24.0, color: Colors.white),
                      text: S.of(context).clear,
                    ),
                  ),
                  15.0.horizontalSpace,
                  Expanded(
                    flex: 4,
                    child: MyButton(
                      elevation: 0.0,
                      color: state.isRead ? Colors.red : null,
                      onTap: () {
                        context.read<ScanCubit>().readOrStop();
                      },
                      icon: ImageMultiType(
                        url: state.isRead
                            ? Assets.iconsStopCircle
                            : Icons.play_circle_outline_rounded,
                        height: 24.0,
                        color: Colors.white,
                      ),
                      text: state.isRead ? S.of(context).stop : S.of(context).start,
                    ),
                  ),
                ],
              ),
              if (search != null) 5.0.verticalSpace,
              if (search != null) search!,
            ],
          ),
        );
      },
    );
  }
}
