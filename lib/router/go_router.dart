import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/features/auth/ui/pages/splash_screen_page.dart';
import 'package:rfid_project/features/home/ui/widget/screens/menu_screen.dart';

import '../core/injection/injection_container.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/home/ui/pages/home_page.dart';
import 'go_route_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: navigatorKey,
  observers: [MyRouteObserver()],
  routes: [
    //region splash
    ///Splash
    GoRoute(
      path: RouteName.splash,
      name: RouteName.splash,
      builder: (_, state) {
        return SplashScreenPage();
      },
    ),
    //endregion

    //region auth
    ///signup
    GoRoute(
      path: RouteName.signup,
      name: RouteName.signup,
      builder: (_, state) {
        final providers = [BlocProvider(create: (_) => sl<SignupCubit>())];
        return MultiBlocProvider(providers: providers, child: const SignupPage());
      },
    ),

    ///login
    GoRoute(
      path: RouteName.login,
      name: RouteName.login,
      builder: (_, state) {
        final providers = [BlocProvider(create: (_) => sl<LoginCubit>())];
        return MultiBlocProvider(providers: providers, child: const LoginPage());
      },
    ),

    //endregion

    //region settings
    ///settings
    GoRoute(
      path: RouteName.settings,
      name: RouteName.settings,
      builder: (_, state) {
        final providers = [
          BlocProvider(create: (_) => sl<LoginCubit>()),
        ];
        return MultiBlocProvider(
          providers: providers,
          child: const MenuScreen(),
        );
      },
    ),
    //endregion

    //region home

    ///
    GoRoute(
      path: RouteName.home,
      name: RouteName.home,
      builder: (_, state) {
        return Homepage();
      },
    ),

    //endregion
  ],
);

class RouteName {
  static const splash = '/';
  static const welcomeScreen = '/welcomeScreen';
  static const userSurvey = '/userSurvey';
  static const home = '/home';
  static const forgetPassword = '/forgetPassword';
  static const subscription = '/subscription';

  static const login = '/login';
  static const agreement = '/agreement';
  static const signup = '/signup';
  static const confirmCode = '/confirmCode';
  static const createPasswordPage = '/donePage';
  static const searchShipment = '/searchShipment';
  static const notifications = '/notifications';

  // static const map = '/map';
  static const settings = '/settings';
}
