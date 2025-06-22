import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'features/home/bloc/home_cubit/home_cubit.dart';
import 'features/notification/bloc/notification_count_cubit/notification_count_cubit.dart';
import 'package:flutter/services.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

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

    await Note.initialize();

    await AppInfoService.initial();

    await di.init();
    RfidReader.getData();
  } catch (e) {
    loggerObject.e(e);
  }

  HttpOverrides.global = MyHttpOverrides();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<NotificationCountCubit>()),
        BlocProvider(create: (_) => di.sl<HomeCubit>()),
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

class Note {
  static Future initialize() async {
    var androidInitialize = const AndroidInitializationSettings('mipmap/ic_launcher');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showBigTextNotification({
    var id = 0,
    required String title,
    required String body,
    var payload,
  }) async {
    // var vibrationPattern = Int64List(2);
    // vibrationPattern[0] = 1000;
    // vibrationPattern[1] = 1000;

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Ali Gabory',
      'Gabory App',
      playSound: true,
      // enableVibration: true,
      // sound: RawResourceAndroidNotificationSound('sound'),
      // vibrationPattern: vibrationPattern,
      importance: Importance.defaultImportance,
      priority: Priority.high,
    );

    var not = const NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      (DateTime.now().millisecondsSinceEpoch ~/ 1000),
      title,
      body,
      not,
    );
  }
}

class RfidReader {
  static const MethodChannel _channel = MethodChannel('rfid_channel');

  static Future<bool> init() async {
    try {
      return await _channel.invokeMethod('init');
    } on PlatformException catch (e) {
      loggerObject.f("Failed to init RFID: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> dispose() async {
    try {
      return await _channel.invokeMethod('dispose');
    } on PlatformException catch (e) {
      loggerObject.f("Failed to dispose RFID: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> readOrStop() async {
    try {
      return await _channel.invokeMethod('readOrStop');
    } on PlatformException catch (e) {
      loggerObject.f("Failed to toggle read: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> clear() async {
    try {
      return await _channel.invokeMethod('clear');
    } on PlatformException catch (e) {
      loggerObject.f("Failed to clear: '${e.message}'.");
      return false;
    }
  }

  static Future<bool> getStatus() async {
    try {
      return await _channel.invokeMethod('getStatus');
    } on PlatformException catch (e) {
      loggerObject.f("Failed to get status: '${e.message}'.");
      return false;
    }
  }

  static Future<List<String>> getData() async {
    try {
      final data = await _channel.invokeMethod('getData');
      final l = List<String>.from(data);
      loggerObject.w(l);
      return l;
    } on PlatformException catch (e) {
      loggerObject.f("Failed to get data: '${e.message}'.");
      return [];
    }
  }

  static Future<bool> setReadType(int type) async {
    try {
      return await _channel.invokeMethod('setReadType', type);
    } on PlatformException catch (e) {
      loggerObject.f("Failed to set read type: '${e.message}'.");
      return false;
    }
  }
}
