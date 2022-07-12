// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:quanto/dio_config.dart';
import 'package:quanto/menu/guillotine.dart';
import 'package:quanto/util/snac_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageEditar extends StatefulWidget {
  const PageEditar({Key? key}) : super(key: key);

  @override
  _PageEditarState createState() => _PageEditarState();
}

class _PageEditarState extends State<PageEditar> {
  final TextEditingController _controllerkmAtual = TextEditingController();
  final TextEditingController _controllerValorLitro =
      MoneyMaskedTextController(decimalSeparator: '.');
  final TextEditingController _controllerValorReais =
      MoneyMaskedTextController(decimalSeparator: '.');
  final TextEditingController _controllerQtdLitrosAbastecido =
      MoneyMaskedTextController(decimalSeparator: '.');
  final TextEditingController _controllerPosto = TextEditingController();
  final FocusNode _focusKmAtual = FocusNode();
  final FocusNode _focusValorLitro = FocusNode();
  final FocusNode _focusValorReais = FocusNode();
  final FocusNode _focusQtdLitro = FocusNode();
  final FocusNode _focusPosto = FocusNode();
  String dropdownValue = 'Etanol';
  String _textoResultado = "Edite seu abastecimento";

  @override
  void initState() {
    getIdEditar();
    super.initState();
    _recuperaDados();
  }

  getIdEditar() async {
    final prefs = await SharedPreferences.getInstance();
    final int? _idEditar = prefs.getInt('id_editar');
  }

  _recuperaDados() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final String? _email = prefs.getString('email');
      final int? _id = prefs.getInt('id_editar');

      FormData data = FormData.fromMap({'email': _email, 'id': _id});
      Response res = await dioInstance()
          .post("/quanto_rendes/registro_abastecimento_show", data: data);

      //tratamento antes de atualizar
      String _qtd = res.data['abastecimento']['qtd_litro_abstecido'] ?? '';
      String _posto = res.data['abastecimento']['posto'] ?? '';
      String _valor_litro = res.data['abastecimento']['valor_litro'].toString();
      _valor_litro.contains('.')
          ? _valor_litro
          : _valor_litro = _valor_litro + '.00';
      String _valor_reais = res.data['abastecimento']['valor_reais'].toString();
      _valor_reais.contains('.')
          ? _valor_reais
          : _valor_reais = _valor_reais + '.00';

      setState(() {
        _controllerkmAtual.text =
            res.data['abastecimento']['km_atual'].toString();
        _controllerValorLitro.text = _valor_litro;
        _controllerValorReais.text = _valor_reais;
        _controllerQtdLitrosAbastecido.text = _qtd;
        _controllerPosto.text = _posto;
      });
    } catch (e) {
      if (e is DioError) {
        if (e.response?.data['message'] != null) {
          // print('Erro em carregar registros de abastecimento -> ${e.response}');
        }
      }
      // print('ERRO $e');
    }
  }

  _salvarAbastecimento() async {
    final prefs = await SharedPreferences.getInstance();

    final String? _email = prefs.getString('email');
    final int? _id = prefs.getInt('id_editar');

    FormData data = FormData.fromMap({'email': _email, 'id': _id});
    Response res = await dioInstance()
        .post("/quanto_rendes/registro_abastecimento_edit", data: data);
  }

  _limpar() {
    setState(() {
      _textoResultado = "Edite seu abastecimento";
      _controllerkmAtual.clear();
      _controllerValorLitro.clear();
      _controllerValorReais.clear();
      _controllerQtdLitrosAbastecido.clear();
      _controllerPosto.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _focusKmAtual.unfocus();
        _focusValorLitro.unfocus();
        _focusValorReais.unfocus();
        _focusQtdLitro.unfocus();
        _focusPosto.unfocus();
      },
      child: Scaffold(
        body: Container(
          color: Colors.teal[900],
          padding: const EdgeInsets.all(20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 0,
                    ),
                    child: Text(
                      _textoResultado,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextField(
                    focusNode: _focusKmAtual,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Km Atual, ex: 118877.5",
                      suffixIcon: IconButton(
                        onPressed: () => _controllerkmAtual.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 19),
                    controller: _controllerkmAtual,
                  ),
                  TextField(
                    focusNode: _focusValorLitro,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Valor do Litro, ex: 5.14",
                      suffixIcon: IconButton(
                        onPressed: () => _controllerValorLitro.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                    controller: _controllerValorLitro,
                  ),
                  TextField(
                    focusNode: _focusValorReais,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Valor em reais, ex: 209.09",
                      suffixIcon: IconButton(
                        onPressed: () => _controllerValorReais.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                    controller: _controllerValorReais,
                  ),
                  TextField(
                    focusNode: _focusQtdLitro,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Qtd em litros abastecido, ex: 40.61",
                      suffixIcon: IconButton(
                        onPressed: () => _controllerQtdLitrosAbastecido.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                    controller: _controllerQtdLitrosAbastecido,
                  ),
                  TextField(
                    focusNode: _focusPosto,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Posto de combustível",
                      suffixIcon: IconButton(
                        onPressed: () => _controllerPosto.clear(),
                        icon: const Icon(
                          Icons.clear,
                        ),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                    ),
                    controller: _controllerPosto,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            "Limpar info",
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () => _limpar(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 15,
                          right: 15,
                        ),
                        child: RaisedButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(15),
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () {
                            //TODO: Salvar a edicao dos novos dados do

                            _salvarAbastecimento();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const Guillotine(),
                            //   ),
                            // );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
