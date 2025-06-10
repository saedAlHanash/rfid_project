import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/app/app_provider.dart';
import 'package:rfid_project/core/strings/app_color_manager.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/features/auth/bloc/delete_account_cubit/delete_account_cubit.dart';
import 'package:rfid_project/features/profile/bloc/update_profile_cubit/update_profile_cubit.dart';

import '../../features/notification/bloc/all_notification_cubit/all_notification_cubit.dart';
import '../../features/profile/bloc/get_me_cubit/get_me_cubit.dart';
import '../../generated/assets.dart';
import '../../generated/l10n.dart';
import '../../router/go_router.dart';
import '../app_theme.dart';
import '../injection/injection_container.dart';
import '../util/shared_preferences.dart';
import 'bloc/loading_cubit.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static Future<void> setLocale(BuildContext context, String langCode) async {
    await AppSharedPreference.cashLocal(langCode);
    if (context.mounted) {
      final state = context.findAncestorStateOfType<_MyAppState>();
      await state?.setLocale(Locale.fromSubtags(languageCode: AppSharedPreference.getLocal));
    }
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    S.load(Locale(AppSharedPreference.getLocal));

    setImageMultiTypeErrorImage(
      const Opacity(opacity: 0.3, child: ImageMultiType(url: Assets.imagesLogo, height: 30.0, width: 30.0)),
    );
    super.initState();
  }

  Future<void> setLocale(Locale locale) async {
    AppSharedPreference.cashLocal(locale.languageCode);
    await S.load(locale);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    loggerObject.w(AppSharedPreference.getToken);
    return ScreenUtilInit(
      designSize: MediaQuery.of(context).size,
      // designSize: const Size(375, 812),
      // designSize: const Size(14440, 972),
      minTextAdapt: true,
      // splitScreenMode: true,
      builder: (context, child) {
        DrawableText.initial(
          initialHeightText: 1.5.sp,
          initialSize: 14.0.sp,
          selectable: false,
          initialFont: FontManager.semeBold.name,
          initialColor: AppColorManager.black,
        );

        return MaterialApp.router(
          routerConfig: goRouter,
          locale: Locale.fromSubtags(languageCode: AppSharedPreference.getLocal),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          builder: (_, child) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => sl<LoadingCubit>()),
                BlocProvider(create: (_) => sl<DeleteAccountCubit>()),
                BlocProvider(create: (_) => sl<UpdateProfileCubit>()),
                BlocProvider(create: (_) => sl<GetMeCubit>()..getData()),
                BlocProvider(create: (_) => sl<NotificationCubit>()..getData()),
              ],
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(.85)),
                child: GestureDetector(
                  onTap: () {
                    final currentFocus = FocusScope.of(context);

                    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  child: AppProvider.isTestMode
                      ? SafeArea(
                          bottom: true,
                          top: false,
                          left: false,
                          right: false,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              child!,
                              IgnorePointer(
                                child: ImageMultiType(
                                  height: 100.0.h,
                                  width: 100.0.w,
                                  color: Colors.grey,
                                  url: Assets.imagesTestMode,
                                ),
                              ),
                            ],
                          ),
                        )
                      : child!,
                ),
              ),
            );
          },
          scrollBehavior: MyCustomScrollBehavior(),
          debugShowCheckedModeBanner: false,
          theme: appTheme,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}

BuildContext? get ctx => sl<GlobalKey<NavigatorState>>().currentContext;
