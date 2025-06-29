import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:m_cubit/caching_service/caching_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/error/error_manager.dart';
import 'package:rfid_project/core/util/checker_helper.dart';
import 'package:rfid_project/services/app_info_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/app/app_widget.dart';
import 'core/injection/injection_container.dart' as di;
import 'core/util/shared_preferences.dart';
import 'features/database/import_db.dart';
import 'features/home/bloc/home_cubit/home_cubit.dart';
import 'features/notification/bloc/notification_count_cubit/notification_count_cubit.dart';
import 'features/scan/bloc/scan_cubit/scan_cubit.dart';

// final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await SharedPreferences.getInstance().then((value) {
      AppSharedPreference.init(value);
    });

    appData = await PackageInfo.fromPlatform();
    await CachingService.initial(
      onError: (second) {
        showErrorFromApi(second);
      },
      version: 2,
      supperFilter: AppProvider.supperFilter,
      timeInterval: 60,
    );

    // await Note.initialize();
    await importNewDatabaseFromApi();

    await AppInfoService.initial();

    await di.init();
  } catch (e) {
    loggerObject.e(e);
  }

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<NotificationCountCubit>()),
        BlocProvider(create: (_) => di.sl<HomeCubit>()),
        BlocProvider(create: (_) => di.sl<ScanCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };
  }
}
