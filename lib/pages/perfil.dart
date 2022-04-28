// ignore_for_file: deprecated_member_use, duplicate_ignore
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final bool _subindoImagem = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[900],
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: _subindoImagem
                      ? const CircularProgressIndicator()
                      : Container(),
                ),
                // ignore: prefer_const_constructors
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      child: const Text("Câmera"),
                      onPressed: () {
                        // _recuperarImagem("camera");
                      },
                    ),
                    FlatButton(
                      child: const Text("Galeria"),
                      onPressed: () {
                        // _recuperarImagem("galeria");
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    // controller: _controllerNome,
                    autofocus: false,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 20),
                    /*onChanged: (texto){
                      _atualizarNomeFirestore(texto);
                    },*/
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                      hintText: "Nome",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 10),
                  child: RaisedButton(
                    child: const Text(
                      "Salvar",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.teal,
                    padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    onPressed: () {
                      // _atualizarNomeFirestore();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
