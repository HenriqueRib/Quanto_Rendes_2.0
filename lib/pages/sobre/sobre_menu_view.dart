// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get_it/get_it.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:teste_projeto_47/main.dart';
import 'package:teste_projeto_47/store/config.dart';
import 'package:teste_projeto_47/utils/class_builder.dart';
import 'package:teste_projeto_47/utils/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/notifications.dart';

final config = GetIt.I.get<Config>();

class SobreMenuView extends StatefulWidget {
  const SobreMenuView({Key? key}) : super(key: key);

  @override
  State<SobreMenuView> createState() => _SobreMenuViewState();
}

class _SobreMenuViewState extends State<SobreMenuView> {
  KFDrawerController? _drawerController;
  SnakeShape snakeShape = SnakeShape.circle;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = true;
  Color selectedColor = Constants.color2;

  @override
  void initState() {
    super.initState();
    _getMenuLateral();
  }

  _getMenuLateral() {
    return _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('SobreView'),
      items: [
        KFDrawerItem(
          text: Text(
            "Contato",
            style: const TextStyle(color: Constants.color1),
          ),
          icon: const Icon(Icons.contact_mail, color: Constants.color1),
          onPressed: () async {
            String? url = "https://www.forseti.com.br/contato/";
            final Uri toLaunch = Uri(
                scheme: 'https', host: "www.forseti.com.br", path: 'contato/');
            try {
              if (!await launchUrl(
                toLaunch,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $url');
              }
            } catch (_) {
              Clipboard.setData(
                ClipboardData(
                  text: url,
                ),
              );
              Notifications.warning(
                title: "Atenção",
                message:
                    "Seu celular não oferece suporte para abrir diretamente links. Copiamos um link para visualizar o site. Acesse seu navegador e cole o link na barra de endereços.",
                duration: const Duration(seconds: 10),
              );
            }
          },
        ),
        KFDrawerItem(
          text: Text(
            "Canal Youtube",
            style: const TextStyle(color: Constants.color1),
          ),
          icon:
              const Icon(Icons.video_library_outlined, color: Constants.color1),
          onPressed: () async {
            String? url =
                "https://www.youtube.com/channel/UCicrN6kDop7nUHKG-fFLpBw";
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: "www.youtube.com",
                path: 'channel/UCicrN6kDop7nUHKG-fFLpBw');
            try {
              if (!await launchUrl(
                toLaunch,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $url');
              }
            } catch (_) {
              Clipboard.setData(
                ClipboardData(
                  text: url,
                ),
              );
              Notifications.warning(
                title: "Atenção",
                message:
                    "Seu celular não oferece suporte para abrir diretamente links. Copiamos um link para visualizar o site. Acesse seu navegador e cole o link na barra de endereços.",
                duration: const Duration(seconds: 10),
              );
            }
          },
        ),
        KFDrawerItem(
          text: Text(
            "Produtos",
            style: const TextStyle(color: Constants.color1),
          ),
          icon: const Icon(Icons.local_grocery_store_outlined,
              color: Constants.color1),
          onPressed: () async {
            String? url = "https://www.forseti.com.br/plataforma-elicitacao/";
            final Uri toLaunch = Uri(
                scheme: 'https',
                host: "www.forseti.com.br",
                path: 'plataforma-elicitacao/');
            try {
              if (!await launchUrl(
                toLaunch,
                mode: LaunchMode.externalApplication,
              )) {
                throw Exception('Could not launch $url');
              }
            } catch (_) {
              Clipboard.setData(
                ClipboardData(
                  text: url,
                ),
              );
              Notifications.warning(
                title: "Atenção",
                message:
                    "Seu celular não oferece suporte para abrir diretamente links. Copiamos um link para visualizar o site. Acesse seu navegador e cole o link na barra de endereços.",
                duration: const Duration(seconds: 10),
              );
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: KFDrawer(
                controller: _drawerController,
                header: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Image.asset(
                          'assets/img/logo.png',
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      const Text(Constants.versionApp),
                    ],
                  ),
                ),
                footer: KFDrawerItem(
                  text: const Text(
                    'Sair',
                    style: TextStyle(color: Constants.color1),
                  ),
                  icon: const Icon(
                    Icons.input,
                    color: Constants.color1,
                  ),
                  onPressed: () async {
                    await sharedPreferences?.remove('token');
                    await sharedPreferences?.remove('fcmToken');
                    QR.navigator.replaceAllWithName('login');
                  },
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 1.0),
                      Constants.color1,
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
