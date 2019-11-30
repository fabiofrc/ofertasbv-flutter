
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sobre"),
        elevation: 0.0,
      ),
      body: Container(
        child: Center(
          child: Text("O NOSSO APP \n VERSÃO 1.0"),
        ),
      ),
    );
  }
}
