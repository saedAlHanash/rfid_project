import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:rfid_project/core/widgets/app_bar/app_bar_widget.dart';
import 'package:rfid_project/core/widgets/refresh_widget/refresh_widget.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:go_router/go_router.dart';import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/round_image_widget.dart';

import '../../../../core/strings/app_color_manager.dart';
import '../../../../core/util/my_style.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../../core/widgets/not_found_widget.dart';
import '../../../../router/go_router.dart';
import '../../bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../bloc/notification_count_cubit/notification_count_cubit.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    context.read<NotificationCubit>().getData();
    AppSharedPreference.clearNotificationCount();
    context.read<NotificationCountCubit>().changeCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        titleText: 'الإشعارات',
      ),
      body: AppProvider.isLogin
          ? BlocBuilder<NotificationCubit, NotificationsInitial>(
              builder: (context, state) {
                if (state.loading) {
                  return MyStyle.loadingWidget();
                }

                final list = state.result;
                return RefreshWidget(
                  isLoading: state.loading,
                  child: state.result.isEmpty
                      ? const NotFoundWidget(
                          text: 'لا توجد إشعارات',
                          icon: Icons.notifications_off_rounded,
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 20.0).h,
                          itemBuilder: (_, i) {
                            return Container(
                              width: 1.0.sw,
                              padding: const EdgeInsets.all(15.0).r,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 5.0).h,
                              color: AppColorManager.lightGray,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (list[i].image.isNotEmpty)
                                    RoundImageWidget(
                                      url: list[i].image,
                                      height: 130.0.h,
                                      width: 370.0.w,
                                    ),
                                  DrawableText(
                                    text: list[i].title,
                                    color: AppColorManager.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  5.0.verticalSpace,
                                  DrawableText(
                                    size: 13.0.sp,
                                    text: list[i].body,
                                    color: AppColorManager.gray,
                                    textAlign: TextAlign.start,
                                    matchParent: true,
                                  ),
                                  5.0.verticalSpace,
                                  DrawableText(
                                    size: 14.0.sp,
                                    text: list[i].date?.formatDate ?? '',
                                    color: AppColorManager.mainColor,
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, i) => 20.0.verticalSpace,
                          itemCount: list.length,
                        ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DrawableText(text: 'يرجى تسجيل الدخول للمتابعة'),
                  20.0.verticalSpace,
                  MyButton(
                    text: 'تسجيل الدخول',
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.login);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
