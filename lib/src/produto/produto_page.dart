import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_create_page.dart';
import 'package:ofertasbv/src/produto/produto_home.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';

class ProdutoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(context: context, delegate: ProdutoSearchDelegate());
            },
          )
        ],
      ),
      body: ProdutoHome(),
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
                  MaterialPageRoute(builder: (context) => ProdutoCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
