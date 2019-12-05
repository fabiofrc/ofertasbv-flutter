import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/arquivo/arquivo_controller.dart';
import 'package:ofertasbv/src/arquivo/arquivo_create_page.dart';
import 'package:ofertasbv/src/arquivo/arquivo_list.dart';
import 'package:ofertasbv/src/categoria/categoria_create_page.dart';
import 'package:ofertasbv/src/categoria/categoria_list.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';



class ArquivoPage extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<ArquivoController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Arquivos"),
        elevation: 0.0,
        actions: <Widget>[
          StreamBuilder<Object>(
            stream: _bloc.counter,
            builder: (context, data) {
              return Chip(
                label: Text(
                  (data.data ?? 0).toString(),
                  style: TextStyle(color: Colors.pink[900]),
                ),
              );
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: ProdutoSearchDelegate());
            },
          )
        ],
      ),
      body: ArquivoList(),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArquivoCreatePage()));
            },
          )
        ],
      ),
    );
  }
}