import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rfid_project/features/asset/bloc/asset_cubit/asset_cubit.dart';
import 'package:rfid_project/features/asset/bloc/assets_cubit/assets_cubit.dart';
import 'package:rfid_project/features/product/bloc/product_cubit/product_cubit.dart';
import 'package:rfid_project/features/product/bloc/products_cubit/products_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';

import '../../features/auth/bloc/login_cubit/login_cubit.dart';

import '../../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../../features/home/bloc/home_cubit/home_cubit.dart';
import '../../features/notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../features/notification/bloc/notification_count_cubit/notification_count_cubit.dart';
import '../../features/profile/bloc/delete_my_account_cubit/delete_my_account_cubit.dart';
import '../../features/profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';
import '../../features/report/bloc/report_cubit/report_cubit.dart';
import '../../features/report/bloc/reports_cubit/reports_cubit.dart';
import '../app/bloc/loading_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //region product
  sl.registerFactory(() => ProductCubit());
  sl.registerFactory(() => ProductsCubit());
  //endregion

  //region report
  sl.registerFactory(() => ReportCubit());
  sl.registerFactory(() => ReportsCubit());
  //endregion

  //region asset
  sl.registerFactory(() => AssetCubit());
  sl.registerFactory(() => AssetsCubit());
  //endregion

  //region Core

  sl.registerLazySingleton(() => LoadingCubit());
  sl.registerLazySingleton(() => GlobalKey<NavigatorState>());

  sl.registerLazySingleton(() => HomeCubit());

  //endregion

  //region auth

  sl.registerFactory(() => LoginCubit());

  sl.registerFactory(() => ResetPasswordCubit());
  sl.registerFactory(() => SignupCubit());
  sl.registerFactory(() => DeleteAccountCubit());

  //endregion

  // region profile
  sl.registerFactory(() => DeleteMyAccountCubit());
  sl.registerFactory(() => GetMeCubit());
  sl.registerFactory(() => UpdateProfileCubit());

  //endregion

  //region Notification
  sl.registerFactory(() => NotificationCubit());
  sl.registerFactory(() => NotificationCountCubit());
  //endregion

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
