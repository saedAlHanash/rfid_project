import '../features/product/bloc/product_cubit/product_cubit.dart';
import '../features/product/bloc/products_cubit/products_cubit.dart';
import '../features/product/ui/pages/add_product_page.dart';
import '../features/product/ui/pages/product_page.dart';
import '../features/product/ui/pages/products_page.dart';

import '../features/report/bloc/report_cubit/report_cubit.dart';
import '../features/report/bloc/reports_cubit/reports_cubit.dart';
import '../features/report/ui/pages/report_page.dart';
import '../features/report/ui/pages/reports_page.dart';

import '../features/asset/bloc/asset_cubit/asset_cubit.dart';
import '../features/asset/bloc/assets_cubit/assets_cubit.dart';
import '../features/asset/ui/pages/asset_page.dart';
import '../features/asset/ui/pages/assets_page.dart';

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
    //region product

    ///product
    GoRoute(
      path: RouteName.product,
      name: RouteName.product,
      builder: (_, state) {
        String productId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ProductCubit>()..getData(productId: productId),
            ),
          ],
          child: ProductPage(),
        );
      },
    ),
    ///addProduct
    GoRoute(
      path: RouteName.addProduct,
      name: RouteName.addProduct,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ProductsCubit>(),
            ),
          ],
          child: AddProductPage(),
        );
      },
    ),

    ///products
    GoRoute(
      path: RouteName.products,
      name: RouteName.products,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ProductsCubit>()..getData(),
            ),
          ],
          child: ProductsPage(),
        );
      },
    ),
    //endregion

    //region report

    ///report
    GoRoute(
      path: RouteName.report,
      name: RouteName.report,
      builder: (_, state) {
        String reportId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ReportCubit>()..getData(reportId: reportId),
            ),
          ],
          child: ReportPage(),
        );
      },
    ),

    ///reports
    GoRoute(
      path: RouteName.reports,
      name: RouteName.reports,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ReportsCubit>()..getData(),
            ),
          ],
          child: ReportsPage(),
        );
      },
    ),
    //endregion

    //region asset

    ///asset
    GoRoute(
      path: RouteName.asset,
      name: RouteName.asset,
      builder: (_, state) {
        String assetId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AssetCubit>()..getData(assetId: assetId),
            ),
          ],
          child: AssetPage(),
        );
      },
    ),

    ///assets
    GoRoute(
      path: RouteName.assets,
      name: RouteName.assets,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<AssetsCubit>()..getData(),
            ),
          ],
          child: AssetsPage(),
        );
      },
    ),
    //endregion

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
  static const product = '/product';
  static const products = '/products';
  static const addProduct = '/addProduct';

  static const report = '/report';
  static const reports = '/reports';

  static const room = '/room';
  static const rooms = '/rooms';

  static const department = '/department';
  static const departments = '/departments';

  static const asset = '/asset';
  static const assets = '/assets';

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
