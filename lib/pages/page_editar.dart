import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageEditar extends StatefulWidget {
  const PageEditar({Key? key}) : super(key: key);

  @override
  _PageEditarState createState() => _PageEditarState();
}

class _PageEditarState extends State<PageEditar> {
  @override
  void initState() {
    getIdEditar();
    super.initState();
  }

  getIdEditar() async {
    final prefs = await SharedPreferences.getInstance();
    final String? _idEditar = prefs.getString('id_editar'); // Recuperar
    print(_idEditar);
    print('_idEditar');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[200],
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Image.asset(
                    "images/carro-azul.png",
                    width: 200,
                    height: 150,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
