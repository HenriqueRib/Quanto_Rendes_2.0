import 'package:flutter/material.dart';
import 'package:quanto/widgets/menu_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    _getInfo();
    super.initState();
  }

  final List<Map> _menus = <Map>[
    {
      "icon": Icons.view_agenda,
      "title": "Visualizar",
      "color": Colors.teal,
      'route': "/visualizar"
    },
    {
      "icon": Icons.edit,
      "title": "Marcar",
      "color": Colors.teal,
      'route': "/marcar"
    },
    {
      "icon": Icons.calculate,
      "title": "Calcular",
      "color": Colors.teal,
      'route': "/aplicacao"
    },
    {
      "icon": Icons.person,
      "title": "Perfil",
      "color": Colors.teal,
      'route': "/perfil"
    },
    // {
    //   "icon": Icons.settings,
    //   "title": "Configuração",
    //   "color": Colors.teal,
    //   'route': "/configuracao"
    // },
    {
      "icon": Icons.login,
      "title": "Login",
      "color": Colors.teal,
      'route': "/login"
    },
  ];

  String? nome;
  _getInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nome = prefs.getString('nome');
    });
  }

  Future<void> _refresh() async {
    _getInfo();
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        displacement: 700,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/background.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 1,
              color: Colors.blue,
            ),
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  var futures = <Future>[];
                  await Future.wait(futures);
                  return Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "",
                                      style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: SizedBox(
                                      height: 75,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                          _menus.length,
                                          (index) {
                                            return MenuCard(
                                              index: index,
                                              menuItem: _menus,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "Bem vindo $nome \n ao Quanto Rendes",
                                      style: const TextStyle(
                                        fontSize: 21,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
