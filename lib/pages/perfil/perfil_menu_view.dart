// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get_it/get_it.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:quanto/main.dart';
import 'package:quanto/store/config.dart';
import 'package:quanto/utils/class_builder.dart';
import 'package:quanto/utils/constants.dart';
import 'package:qlevar_router/qlevar_router.dart';

final config = GetIt.I.get<Config>();

class PerfilMenuView extends StatefulWidget {
  const PerfilMenuView({Key? key}) : super(key: key);

  @override
  State<PerfilMenuView> createState() => _PerfilMenuViewState();
}

class _PerfilMenuViewState extends State<PerfilMenuView> {
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
      initialPage: ClassBuilder.fromString('PerfilView'),
      items: [
        KFDrawerItem(
          text: const Text(
            "main",
            style: TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.person_outline_sharp, color: Colors.white),
          onPressed: () {
            QR.to('/perfil');
          },
        ),
        KFDrawerItem(
          text: Text(
            "minhas_compras",
            style: const TextStyle(color: Colors.white),
          ),
          icon: const Icon(Icons.payment_sharp, color: Colors.white),
          onPressed: () {
            QR.to('/compras');
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
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: const Icon(
                    Icons.input,
                    color: Colors.white,
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
