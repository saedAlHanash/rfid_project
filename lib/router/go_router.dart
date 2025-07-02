import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/features/asset/data/request/create_asset_request.dart';
import 'package:rfid_project/features/product/ui/pages/add_product_page.dart';
import 'package:rfid_project/features/product/ui/pages/find_product.dart';
import 'package:rfid_project/features/auth/ui/pages/splash_screen_page.dart';
import 'package:rfid_project/features/home/ui/widget/screens/menu_screen.dart';
import 'package:rfid_project/features/product/ui/pages/move_product_page.dart';

import '../core/injection/injection_container.dart';
import '../core/strings/enum_manager.dart';
import '../features/asset/bloc/asset_cubit/asset_cubit.dart';
import '../features/asset/bloc/assets_cubit/assets_cubit.dart';
import '../features/asset/ui/pages/asset_page.dart';
import '../features/asset/ui/pages/assets_page.dart';
import '../features/product/ui/pages/delete_product.dart';
import '../features/product/ui/pages/edit_product_page.dart';
import '../features/product/ui/pages/scan_page.dart';
import '../features/auth/bloc/login_cubit/login_cubit.dart';
import '../features/auth/bloc/signup_cubit/signup_cubit.dart';
import '../features/auth/ui/pages/login_page.dart';
import '../features/auth/ui/pages/signup_page.dart';
import '../features/department/bloc/department_cubit/department_cubit.dart';
import '../features/department/bloc/departments_cubit/departments_cubit.dart';
import '../features/department/ui/pages/department_page.dart';
import '../features/department/ui/pages/departments_page.dart';
import '../features/division/bloc/division_cubit/division_cubit.dart';
import '../features/division/bloc/divisions_cubit/divisions_cubit.dart';
import '../features/division/ui/pages/division_page.dart';
import '../features/division/ui/pages/divisions_page.dart';
import '../features/entity/bloc/entities_cubit/entities_cubit.dart';
import '../features/entity/bloc/entity_cubit/entity_cubit.dart';
import '../features/entity/ui/pages/entities_page.dart';
import '../features/entity/ui/pages/entity_page.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/product/bloc/product_cubit/product_cubit.dart';
import '../features/product/bloc/products_cubit/products_cubit.dart';
import '../features/product/data/response/product_response.dart';
import '../features/product/ui/pages/product_page.dart';
import '../features/product/ui/pages/products_page.dart';
import '../features/report/bloc/report_cubit/report_cubit.dart';
import '../features/report/bloc/report_scan_cubit/report_scan_cubit.dart';
import '../features/report/bloc/reports_cubit/reports_cubit.dart';
import '../features/report/ui/pages/find_room.dart';
import '../features/report/ui/pages/report_page.dart';
import '../features/report/ui/pages/report_scan.dart';
import '../features/report/ui/pages/reports_page.dart';
import '../features/room/bloc/room_cubit/room_cubit.dart';
import '../features/room/bloc/rooms_cubit/rooms_cubit.dart';
import '../features/room/ui/pages/room_page.dart';
import '../features/room/ui/pages/rooms_page.dart';
import '../services/beep_service.dart';
import 'go_route_observer.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: navigatorKey,
  observers: [MyRouteObserver()],
  routes: [
    //region entity

    ///entity
    GoRoute(
      path: RouteName.entity,
      name: RouteName.entity,
      builder: (_, state) {
        String entityId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<EntityCubit>()..getData(entityId: entityId),
            ),
          ],
          child: EntityPage(),
        );
      },
    ),

    ///entities
    GoRoute(
      path: RouteName.entities,
      name: RouteName.entities,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<EntitiesCubit>()..getData(),
            ),
          ],
          child: EntitiesPage(),
        );
      },
    ),
    //endregion

    //region room

    ///room
    GoRoute(
      path: RouteName.room,
      name: RouteName.room,
      builder: (_, state) {
        String roomId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<RoomCubit>()..getData(roomId: roomId),
            ),
          ],
          child: RoomPage(),
        );
      },
    ),

    ///rooms
    GoRoute(
      path: RouteName.rooms,
      name: RouteName.rooms,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<RoomsCubit>()..getData(),
            ),
          ],
          child: RoomsPage(),
        );
      },
    ),
    //endregion

    //region division

    ///division
    GoRoute(
      path: RouteName.division,
      name: RouteName.division,
      builder: (_, state) {
        String divisionId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<DivisionCubit>()..getData(divisionId: divisionId),
            ),
          ],
          child: DivisionPage(),
        );
      },
    ),

    ///divisions
    GoRoute(
      path: RouteName.divisions,
      name: RouteName.divisions,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<DivisionsCubit>()..getData(),
            ),
          ],
          child: DivisionsPage(),
        );
      },
    ),
    //endregion

    //region department

    ///department
    GoRoute(
      path: RouteName.department,
      name: RouteName.department,
      builder: (_, state) {
        String departmentId = state.uri.queryParameters['id'] ?? '';
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<DepartmentCubit>()..getData(departmentId: departmentId),
            ),
          ],
          child: DepartmentPage(),
        );
      },
    ),

    ///departments
    GoRoute(
      path: RouteName.departments,
      name: RouteName.departments,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<DepartmentsCubit>()..getData(),
            ),
          ],
          child: DepartmentsPage(),
        );
      },
    ),
    //endregion

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
              create: (_) => sl<ProductCubit>()..getData(),
            ),
          ],
          child: ProductPage(),
        );
      },
    ),

    ///deleteProduct
    GoRoute(
      path: RouteName.deleteProduct,
      name: RouteName.deleteProduct,
      builder: (_, state) {
        final product = state.extra as Product;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<ProductsCubit>(),
            ),
          ],
          child: DeleteProduct(product: product),
        );
      },
    ),

    ///moveProduct
    GoRoute(
      path: RouteName.moveProduct,
      name: RouteName.moveProduct,
      builder: (context, state) {
        final product = state.extra as Product;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<AssetsCubit>()
                ..setProduct(product)
                ..getData(),
            ),
            BlocProvider(
              create: (_) => sl<DepartmentsCubit>()
                ..getData(
                  id: product.room.division.department.entity.id,
                  selectedId: product.room.division.department.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<DivisionsCubit>()
                ..getData(
                  id: product.room.division.department.id,
                  selectedId: product.room.division.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<RoomsCubit>()
                ..getData(
                  id: product.room.division.id,
                  selectedId: product.room.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<EntitiesCubit>()
                ..getData(
                  selectedId: product.room.division.department.entity.id,
                ),
            ),
          ],
          child: MoveProductPage(product: product),
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
              create: (_) => sl<ProductsCubit>()..getData(),
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
              create: (_) => sl<ReportCubit>()..getData(reportId: reportId),
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
              create: (_) => sl<ReportsCubit>()..getData(),
            ),
          ],
          child: ReportsPage(),
        );
      },
    ),

    ///findRoom
    GoRoute(
      path: RouteName.findRoom,
      name: RouteName.findRoom,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<DepartmentsCubit>()),
            BlocProvider(create: (_) => sl<DivisionsCubit>()),
            BlocProvider(create: (_) => sl<RoomsCubit>()),
          ],
          child: FindRoom(),
        );
      },
    ),

    ///reportScan
    GoRoute(
      path: RouteName.reportScan,
      name: RouteName.reportScan,
      builder: (_, state) {
        final request = state.extra as CreateAssetRequest;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ReportsCubit>()),
            BlocProvider(
              create: (_) => sl<ReportScanCubit>()..init(request.room.id.toString()),
            ),
          ],
          child: ReportScan(request: request),
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
              create: (_) => sl<AssetCubit>()..getData(assetId: assetId),
            ),
          ],
          child: AssetPage(),
        );
      },
    ),

    ///scan
    GoRoute(
      path: RouteName.assets,
      name: RouteName.assets,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AssetCubit>()),
          ],
          child: AssetsPage(),
        );
      },
    ),

    ///assets
    GoRoute(
      path: RouteName.scan,
      name: RouteName.scan,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<AssetCubit>()..getData(),
            ),
          ],
          child: ScanPage(),
        );
      },
    ),

    ///addAsset
    GoRoute(
      path: RouteName.addAsset,
      name: RouteName.addAsset,
      builder: (_, state) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<DepartmentsCubit>()),
            BlocProvider(create: (_) => sl<DivisionsCubit>()),
            BlocProvider(create: (_) => sl<RoomsCubit>()),
          ],
          child: AddProductPage(),
        );
      },
    ),

    ///findAsset
    GoRoute(
      path: RouteName.findAsset,
      name: RouteName.findAsset,
      builder: (_, state) {
        final actionType =
            ActionType.values[int.tryParse(state.uri.queryParameters['actionType'] ?? '0') ?? 0];
        loggerObject.w(actionType);
        loggerObject.w(state.uri.queryParameters['actionType']);
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<AssetsCubit>()),
            BlocProvider(create: (_) => sl<ProductsCubit>()),
          ],
          child: FinedProductPage(actionType: actionType),
        );
      },
    ),

    ///editAsset
    GoRoute(
      path: RouteName.editAsset,
      name: RouteName.editAsset,
      builder: (context, state) {
        final product = state.extra as Product;

        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => sl<AssetsCubit>()
                ..setProduct(product)
                ..getData(),
            ),
            BlocProvider(
              create: (_) => sl<DepartmentsCubit>()
                ..getData(
                  id: product.room.division.department.entity.id,
                  selectedId: product.room.division.department.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<DivisionsCubit>()
                ..getData(
                  id: product.room.division.department.id,
                  selectedId: product.room.division.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<RoomsCubit>()
                ..getData(
                  id: product.room.division.id,
                  selectedId: product.room.id,
                ),
            ),
            BlocProvider(
              create: (_) => sl<EntitiesCubit>()
                ..getData(
                  selectedId: product.room.division.department.entity.id,
                ),
            ),
          ],
          child: EditProductPage(),
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
  static const entity = '/entity';
  static const entities = '/entities';

  static const room = '/room';
  static const rooms = '/rooms';

  static const division = '/division';
  static const divisions = '/divisions';

  static const department = '/department';
  static const departments = '/departments';

  static const product = '/product';
  static const products = '/products';
  static const addAsset = '/addAsset';

  static const report = '/report';
  static const reports = '/reports';

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
  static const scan = '/scan';
  static const findAsset = '/findAsset';
  static const editAsset = '/editAsset';
  static const deleteProduct = '/deleteProduct';
  static const moveProduct = '/moveProduct';
  static const findRoom = '/findRoom';
  static const reportScan = '/reportScan';
}
