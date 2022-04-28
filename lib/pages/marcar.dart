import 'package:flutter/material.dart';

class MarcarPage extends StatefulWidget {
  const MarcarPage({Key? key}) : super(key: key);

  @override
  _MarcarPageState createState() => _MarcarPageState();
}

class _MarcarPageState extends State<MarcarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal[900],
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
