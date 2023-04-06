import 'package:flutter_easyloading/flutter_easyloading.dart';
// impßort 'package:get_it/get_it.dart';
import 'package:quanto/main.dart';
import 'package:quanto/pages/contato/contato_menu_view.dart';
import 'package:quanto/pages/login/login_view.dart';
import 'package:quanto/pages/main/main_view.dart';
import 'package:quanto/pages/perfil/perfil_menu_view.dart';
import 'package:quanto/pages/sobre/sobre_menu_view.dart';
import 'package:quanto/pages/splash/splash_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../pages/not_found/not_found_view.dart';

// final userStore = GetIt.I.get<UserStore>();

class AppRoutes {
  void setup() {
    QR.settings.initPage = const SplashView();

    QR.settings.notFoundPage = QRoute(
      path: 'path',
      builder: () => const NotFoundView(),
    );
  }

  final routes = <QRoute>[
    QRoute(
      path: '/',
      name: 'login',
      builder: () => const LoginView(),
      middleware: [
        QMiddlewareBuilder(
          redirectGuardFunc: (p0) async {
            // await sharedPreferences?.remove('token');
            if (sharedPreferences!.getString('token').toString() == 'null') {
              return null;
            }
            EasyLoading.show(status: '');
            // ResponseFunction? res = await userStore.getMe();
            // if (res is ResponseFunction) {
            //   if (res.success == true) {
            //     await EasyLoading.dismiss();
            //     return '/main';
            //   }
            //   await EasyLoading.dismiss();
            //   return null;
            // }
            return null;
          },
        ),
      ],
    ),
    QRoute(
      path: '/contato',
      name: 'contato',
      builder: () => const ContatoMenuView(),
    ),
    QRoute(
      path: '/sobre',
      name: 'sobre',
      builder: () => const SobreMenuView(),
    ),
    QRoute(
      path: '/perfil',
      name: 'perfil',
      builder: () => const PerfilMenuView(),
    ),
    QRoute(
      path: '/main',
      name: 'main',
      builder: () => const MainView(),
      // middleware: [
      //   QMiddlewareBuilder(
      //     canPopFunc: null,
      //     onEnterFunc: () async {},
      //     onExitFunc: null,
      //   ),
      // ],
    ),
  ];
}
