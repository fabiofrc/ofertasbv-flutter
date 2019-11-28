import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/pessoa/pessoa_create_page.dart';
import 'package:ofertasbv/src/pessoa/pessoa_home.dart';



class PessoaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mercados"),
      ),
      body: PessoaHome(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 8,
            height: 8,
          ),
          FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PessoaCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
