// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanto/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisualizarPage extends StatefulWidget {
  const VisualizarPage({Key? key}) : super(key: key);

  @override
  _VisualizarPageState createState() => _VisualizarPageState();
}

class _VisualizarPageState extends State<VisualizarPage> {
  @override
  void initState() {
    getAbastecimento();
    super.initState();
  }

  late List _itens = ["A", "B"];

  void getAbastecimento() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final String? _email = prefs.getString('email'); // Recuperar
      final int? _id = prefs.getInt('id'); // Recuperar
      FormData data = FormData.fromMap({'email': _email, 'id': _id});
      Response res =
          await dioInstance().post("/quanto_rendes/visualizar", data: data);

      print('Ok ${res.data}');

      setState(() {
        _itens = res.data['abastecimento'];
      });

      if (res.data['status'] == 'success') {
        // await prefs.setString('email', _controllerEmail.text);
        // Navigator.pushReplacementNamed(context, "/tela_principal");

      }
    } catch (e) {
      // String message = "Erro! Tente novamente mais tarde.";
      if (e is DioError) {
        if (e.response?.data['message'] != null) {
          print('Ok ${e.response}');
          // message = e.response?.data['message'];
        }
      }
      print('ERRO $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[900],
        padding: const EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Expanded(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              child: SizedBox(
                height: 200.0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(50),
                  itemCount: _itens.length,
                  itemBuilder: (context, indice) {
                    // Map<String, dynamic> item = _itens[indice];
                    // print("item ${ _itens[indice]["titulo"] }");
                    return ListTile(
                      title: Text(_itens[indice]),
                      // subtitle: Text(_itens[indice]),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
