import 'package:flutter/material.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_create_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_home.dart';

class SubcategoriaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategorias"),
      ),
      body: SubcategoriaHome(),
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
                  MaterialPageRoute(builder: (context) => SubCategoriaCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
