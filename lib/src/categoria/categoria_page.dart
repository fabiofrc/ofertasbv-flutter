import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/categoria/categoria_home.dart';

import 'categoria_create_page.dart';


class CategoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categorias"),
        elevation: 0.0,
      ),
      body: CategoriaHome(),
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
                  MaterialPageRoute(builder: (context) => CategoriaCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
