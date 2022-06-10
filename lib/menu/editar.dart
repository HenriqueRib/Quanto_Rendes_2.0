import 'package:flutter/material.dart';
import 'package:quanto/pages/menu.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'guillotine_menu.dart';

class Editar extends StatefulWidget {
  const Editar({Key? key}) : super(key: key);

  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  @override
  void initState() {
    getTitle();
    super.initState();
  }

  getTitle() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('menu_title', 'Editar');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Stack(
        alignment: Alignment.topLeft,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Menu(),
          const GuillotineMenu(),
        ],
      ),
    );
  }
}
