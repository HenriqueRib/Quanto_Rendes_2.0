import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:quanto_rendes_2/main.dart';
import 'package:quanto_rendes_2/pages/acolhimento/acolhimento.dart';
import 'package:quanto_rendes_2/pages/adicionar_radar/adicionar_radar.dart';
import 'package:quanto_rendes_2/pages/contato/contato_menu_view.dart';
import 'package:quanto_rendes_2/pages/escolher_responsavel/escolher_responsavel.dart';
import 'package:quanto_rendes_2/pages/licitacao/licitacao_view.dart';
import 'package:quanto_rendes_2/pages/login/login_view.dart';
import 'package:quanto_rendes_2/pages/main/main_view.dart';
import 'package:quanto_rendes_2/pages/mensagens/mensagens_view.dart';
import 'package:quanto_rendes_2/pages/notificacao/notificacao_view.dart';
import 'package:quanto_rendes_2/pages/perfil/perfil_view.dart';
import 'package:quanto_rendes_2/pages/pesquisa/itens/escolher_itens.dart';
import 'package:quanto_rendes_2/pages/pesquisa/pesquisa_view.dart';
import 'package:quanto_rendes_2/pages/sobre/sobre_menu_view.dart';
import 'package:quanto_rendes_2/pages/splash/splash_view.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../pages/not_found/not_found_view.dart';
import '../pages/registrar/registrar_view.dart';
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
      path: '/acolhimento',
      name: 'acolhimento',
      builder: () => const AcolhimentoView(),
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
      path: '/pesquisa',
      name: 'pesquisa',
      builder: () => PesquisaView(),
    ),
    QRoute(
      path: '/escolher_itens',
      name: 'escolher_itens',
      builder: () => EscolherItens(),
    ),
    QRoute(
      path: '/mensagens',
      name: 'mensagens',
      builder: () => MensagensView(),
    ),
    QRoute(
      path: '/registrar',
      name: 'registrar',
      builder: () => RegistrarView(),
    ),
    QRoute(
      path: '/licitacao',
      name: 'licitacao',
      builder: () => const LicitacaoView(),
    ),
    QRoute(
      path: '/escolher_responsavel',
      name: 'escolher_responsavel',
      builder: () => EscolherResponsavel(),
    ),
    QRoute(
      path: '/adicionar_radar',
      name: 'adicionar_radar',
      builder: () => AdicionarRadar(),
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
    QRoute(
      path: '/notificacao',
      name: 'notificacao',
      builder: () => NotificacaoView(),
    ),
    QRoute(
      path: '/perfil',
      name: 'perfil',
      builder: () => PerfilView(),
    ),
  ];
}
