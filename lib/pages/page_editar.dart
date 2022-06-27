// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quanto/dio_config.dart';
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
    final int? _idEditar = prefs.getInt('id_editar'); // Recuperar
  }

  final TextEditingController _controllerkmAtual = TextEditingController();
  final TextEditingController _controllerValorLitro = TextEditingController();
  final TextEditingController _controllerValorReais = TextEditingController();
  final TextEditingController _controllerQtdLitrosAbastecido =
      TextEditingController();
  final TextEditingController _controllerPosto = TextEditingController();
  final FocusNode _focusKmAtual = FocusNode();
  final FocusNode _focusValorLitro = FocusNode();
  final FocusNode _focusValorReais = FocusNode();
  final FocusNode _focusQtdLitro = FocusNode();
  final FocusNode _focusPosto = FocusNode();
  String dropdownValue = 'Etanol';
  String _textoResultado = "Edite seu abastecimento";

  _atualizaDados() async {
    //TODO: Trazer a informacao com base no id da informacao do abastecimento

    final prefs = await SharedPreferences.getInstance();

    try {
      final String? _email = prefs.getString('email'); // Recuperar
      final int? _id = prefs.getInt('id'); // Recuperar
      FormData data = FormData.fromMap({'email': _email, 'id': _id});
      Response res = await dioInstance()
          .post("/quanto_rendes/registro_abastecimento_show", data: data);

      setState(() {
        _textoResultado = "Edite seu abastecimento";
        _controllerkmAtual.text = '152';
        _controllerValorLitro.text = '152';
        _controllerValorReais.text = '152';
        _controllerQtdLitrosAbastecido.text = '152';
        _controllerPosto.text = '152';
      });
      return const Padding(
          padding: EdgeInsets.only(
        bottom: 0,
      ));
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
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  _atualizaDados(),
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 5,
                      right: 5,
                      bottom: 10,
                    ),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.arrow_downward,
                        color: Colors.white,
                      ),
                      elevation: 16,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      underline: Container(
                        height: 2,
                        color: Colors.teal,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['Etanol', 'Gasolina']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
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
                          //onPressed: _salvarAbastecimento
                          onPressed: () {
                            //TODO: Salvar a edicao dos novos dados do
                            // _salvarAbastecimento();
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => TelaResposta(
                            //       valor: _textoResultado,
                            //     ),
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
