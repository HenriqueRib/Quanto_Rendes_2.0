// ignore_for_file: avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:quanto/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisualizarPage extends StatefulWidget {
  const VisualizarPage({Key? key}) : super(key: key);

  @override
  _VisualizarPageState createState() => _VisualizarPageState();
}

class _VisualizarPageState extends State<VisualizarPage> {
  get onPressed => null;

  @override
  void initState() {
    getAbastecimento();
    super.initState();
  }

  late List _itens = [];

  void getAbastecimento() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final String? _email = prefs.getString('email'); // Recuperar
      final int? _id = prefs.getInt('id'); // Recuperar
      FormData data = FormData.fromMap({'email': _email, 'id': _id});
      Response res =
          await dioInstance().post("/quanto_rendes/visualizar", data: data);

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

  void deletarInfo(BuildContext context, id) {
    print("Id -> $id,");
  }

  void _editarInfo(BuildContext context) {
    print(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[900],
        height: MediaQuery.of(context).size.height * 1,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 60),
          itemCount: _itens.length,
          itemBuilder: (context, indice) {
            Map<String, dynamic> item = _itens[indice];
            double _valorLitro = item["valor_litro"];
            int _id = item["id"];
            int _kmAtual = item["km_atual"];
            double _valorReais = item["valor_reais"].toDouble();
            double _qtdLitro = item["qtd_litro_abastecido"].toDouble();
            String _tipoCombustivel = item["tipo_combustivel"];
            String _data = item["data"];
            DateTime dt = DateTime.parse(_data);
            _data = DateFormat("d/MM/yyyy HH:mm:ss").format(dt);

            print("item AQUIIIIII $item");
            return Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                // dismissible: DismissiblePane(onDismissed: () {
                //   deletarInfo;
                // }),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      print("Id -> $_id");
                    },
                    backgroundColor: const Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (BuildContext context) {
                      print("Id -> $_id");
                    },
                    backgroundColor: const Color(0xFF0392CF),
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Editar',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  "KM: $_kmAtual, Qtd litro:  $_qtdLitro, Valor: $_valorReais \nKM rodados:",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  "Combustível: $_tipoCombustivel litro a $_valorLitro em $_data",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void doNothing(BuildContext context) {}
