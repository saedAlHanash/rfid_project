import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:flutter/cupertino.dart';

class MyRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _sendScreenView(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _sendScreenView(newRoute);
    }
  }

  void _sendScreenView(Route route) {
    final screenName = route.settings.name ?? route.settings.arguments?.toString();

    loggerObject.f(screenName);
  }
}
