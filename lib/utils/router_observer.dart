import 'package:qlevar_router/qlevar_router.dart';
import 'package:teste_projeto_47/store/config.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// final _config = Config();
final config = GetIt.I.get<Config>();

class RouterObserver extends RouteObserver<PageRoute<dynamic>> {
  void _setCurrentRoute(/** PageRoute<dynamic> route */) async {
    await Future.delayed(const Duration(seconds: 0))
        .then((_) => config.setRouteName(QR.currentPath));
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _setCurrentRoute(/** route */);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _setCurrentRoute(/** newRoute*/);
    }
  }

  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute) {
    super.didPop(route!, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _setCurrentRoute(/** previousRoute */);
    }
  }
}
