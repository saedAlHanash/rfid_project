import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/features/auth/ui/pages/splash_screen_page.dart';

import '../core/injection/injection_container.dart';
import '../features/auth/bloc/confirm_code_cubit/confirm_code_cubit.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/resend_code_cubit/resend_code_cubit.dart';
import '../features/auth/bloc/reset_password_cubit/reset_password_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/confirm_code_page.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/reset_password_page.dart';
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

    ///restPass
    GoRoute(
      path: RouteName.restPass,
      name: RouteName.restPass,
      builder: (_, state) {
        final providers = [BlocProvider(create: (_) => sl<ResetPasswordCubit>())];
        return MultiBlocProvider(providers: providers, child: ResetPasswordPage());
      },
    ),

    ///confirmCodeAccount
    GoRoute(
      path: RouteName.confirmCodeAccount,
      name: RouteName.confirmCodeAccount,
      builder: (_, state) {
        final providers = [
          BlocProvider(create: (_) => sl<ConfirmCodeCubit>()),
          BlocProvider(create: (_) => sl<ResendCodeCubit>()),
        ];
        return MultiBlocProvider(providers: providers, child: const ConfirmCodePage());
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
  static const profile = '/profile';
  static const updateProfile = '/updateProfile';
  static const availableTime = '/availableTime';
  static const pdfView = '/pdf';

  // static const setPrice = '/setPrice';
  static const personal = '/personal';
  static const available = '/available';
  static const location = '/location';
  static const bank = '/bank';
  static const social = '/social';
  static const employment = '/employment';
  static const documents = '/documents';
  static const signature = '/signature';
  static const elderlyHouseInfo = '/elderlyHouseInfo';
  static const elderLocation = '/elderLocation';
  static const license = '/license';
  static const wallet = '/wallet';
  static const trainerFiles = '/trainerFiles';
  static const goDiets = '/goDiets';
  static const setWeight = '/setWeight';
  static const editWeight = '/editWeight';
  static const dietPlans = '/dietPlans';
  static const dietProgress = '/dietProgress';
  static const mealsPlan = '/mealsPlan';
  static const meal = '/meal';
  static const freeMeals = '/freeMeals';
  static const restPass = '/restPass';
  static const applyAsTrainer = '/applyAsTrainer';
  static const confirmCodeAccount = '/confirmCodeAccount';
  static const bookMarks = '/bookMarks';
  static const createBundle = '/createBundle';
  static const search = '/search';
  static const searchResult = '/searchResult';
  static const plans = '/plans';
  static const changeTime = '/changeTime';
  static const chat = '/chat';
  static const roomsChat = '/roomsChat';
  static const plan = '/plan';
  static const training = '/training';
  static const trainingExercise = '/trainingExercise';
  static const rating = '/rating';
  static const videoCall = '/videoCall';
  static const pdf = '/pdf';
  static const trainer = '/trainer';
  static const trainers = '/trainers';
  static const webView = '/webView';
  static const intro = '/intro';
  static const couponBundleWidget = '/couponBundleWidget';
  static const couponWidget = '/couponWidget';
  static const freePlans = '/freePlans';
  static const myPayment = '/myPayment';
}
