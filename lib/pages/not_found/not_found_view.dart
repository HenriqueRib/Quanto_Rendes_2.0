import 'package:flutter/material.dart';

class NotFoundView extends StatelessWidget {
  const NotFoundView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page is Not Found")),
      body: const Center(
        child: Center(
          child: Card(
            child: Text('This Page is Not Found'),
          ),
        ),
      ),
    );
  }
}
