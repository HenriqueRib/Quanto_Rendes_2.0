// ignore_for_file: avoid_print, deprecated_member_use, unused_label
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:quanto/dio_config.dart';
import 'package:quanto/util/snac_custom.dart';
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
        _itens = [];
        _itens = res.data['abastecimento'];
      });
    } catch (e) {
      // String message = "Erro! Tente novamente mais tarde.";
      if (e is DioError) {
        if (e.response?.data['message'] != null) {
          print('Erro em carregar registros de abastecimento -> ${e.response}');
          // message = e.response?.data['message'];
        }
      }
      print('ERRO $e');
    }
  }

  void deleteRegistro(id) async {
    try {
      FormData data = FormData.fromMap({
        'id': id,
      });

      Response res = await dioInstance()
          .post("/quanto_rendes/delete_registro", data: data);
      if (res.data['status'] == 'success') {
        // print(res.data);
        getAbastecimento();
        SnacCustom.success(
          title: "Legal",
          message: "Sua informações foi deletada com Sucesso",
        );
      }
    } catch (e) {
      if (e is DioError) {
        print(e.response);
      }
      print('ERRO $e');
    }
  }

  void deletarInfo(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Deseja mesmo deletar essa informação?"),
          actions: <Widget>[
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text("Deletar"),
              color: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                deleteRegistro(id);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _editarInfo(BuildContext context, registro) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('id_editar', registro['id']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:
              const Text("Você deseja Editar este registro de abastecimento"),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.red,
                  textColor: Colors.white,
                  child: const Text("Não"),
                  onPressed: () => Navigator.pop(context),
                ),
                FlatButton(
                  child: const Text("Sim"),
                  color: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, "/editar");
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    getAbastecimento();

    return Future.delayed(
      const Duration(seconds: 0),
      SnacCustom.success(
          title: "Legal",
          message: "Suas informações foram atualizadas com Sucesso"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        displacement: 200,
        child: Container(
          color: Colors.teal[900],
          height: MediaQuery.of(context).size.height * 1,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 60),
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
              Map<String, dynamic> item = _itens[indice];
              double _valorLitro = item["valor_litro"].toDouble();
              int _id = item["id"];
              int _kmAtual = item["km_atual"];
              double _valorReais = item["valor_reais"].toDouble();
              double _qtdLitro = item["qtd_litro_abastecido"].toDouble();
              String _tipoCombustivel = item["tipo_combustivel"];
              String _data = item["data"];
              DateTime dt = DateTime.parse(_data);
              _data = DateFormat("d/MM/yyyy HH:mm:ss").format(dt);
              // print(item);
              String _kmRodados = item["km_rodados"] == 0
                  ? 'Não Contabilizado'
                  : item["km_rodados"].toString();

              return Slidable(
                key: const ValueKey(0),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  // dismissible: DismissiblePane(onDismissed: () {
                  //   deletarInfo(context, _id);
                  // }),
                  children: [
                    SlidableAction(
                      onPressed: (BuildContext context) {
                        deletarInfo(context, _id);
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
                        _editarInfo(context, _itens[indice]);
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
                    "KM: $_kmAtual, Qtd litro:  $_qtdLitro, Valor: $_valorReais \nKM rodados: $_kmRodados",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
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
      ),
    );
  }
}

void doNothing(BuildContext context) {}
