// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:quanto/pages/TelaResposta.dart';

class MarcarPage extends StatefulWidget {
  const MarcarPage({Key? key}) : super(key: key);

  @override
  _MarcarPageState createState() => _MarcarPageState();
}

class _MarcarPageState extends State<MarcarPage> {
  final TextEditingController _controllerkmAtual = TextEditingController();
  final TextEditingController _controllerValorLitro = TextEditingController();
  final TextEditingController _controllerValorReais = TextEditingController();
  final TextEditingController _controllerQtdLitrosAbastecido =
      TextEditingController();
  final TextEditingController _controllerPosto = TextEditingController();

  String dropdownValue = 'Etanol';

  String _textoResultado = "Registre seu abastecimento";
  final FocusNode _focusKmAtual = FocusNode();
  final FocusNode _focusValorLitro = FocusNode();
  final FocusNode _focusValorReais = FocusNode();
  final FocusNode _focusQtdLitro = FocusNode();
  final FocusNode _focusPosto = FocusNode();

  _calcularkm() {
    try {
      int kmfinal = int.parse(_controllerkmAtual.text);
      int kminicial = int.parse(_controllerValorLitro.text);
      double qtdCombustivel = double.parse(_controllerValorReais.text);
      int resultado;
      double _kmPorLitro;

      resultado = kmfinal - kminicial;
      if (resultado > 0 || resultado <= 0) {
        setState(() {
          _kmPorLitro = resultado / qtdCombustivel;
          _textoResultado = "Desta vez seu carro fez " +
              _kmPorLitro.toStringAsFixed(
                  _kmPorLitro.truncateToDouble() == _kmPorLitro ? 0 : 2) +
              "km por Combustível!";
        });
      }
    } catch (_) {
      setState(
        () {
          _textoResultado = "Preencha os campos para calcular";
        },
      );
    }
  }

  _limpar() {
    setState(() {
      _textoResultado = "Registre seu abastecimento";
      _controllerkmAtual.clear();
      _controllerValorLitro.clear();
      _controllerValorReais.clear();
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
                      labelText: "Km Atual, ex: 73111",
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
                      labelText: "Valor em reais, ex: 150.00",
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
                            "Limpar dados",
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
                            "Calcular",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          //onPressed: _calcularkm
                          onPressed: () {
                            _calcularkm();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TelaResposta(
                                  valor: _textoResultado,
                                ),
                              ),
                            );
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
