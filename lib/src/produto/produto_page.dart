import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/const.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_create_page.dart';
import 'package:ofertasbv/src/produto/produto_list.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class ProdutoPage extends StatefulWidget {
  Promocao p;
  SubCategoria s;
  ProdutoPage({Key key, this.p, this.s}) : super(key: key);

  @override
  _ProdutoPageState createState() => _ProdutoPageState(p: this.p, s:this.s);
}

class _ProdutoPageState extends State<ProdutoPage> {
  final _bloc = BlocProvider.getBloc<ProdutoController>();

  Promocao p;
  SubCategoria s;
  _ProdutoPageState({this.p, this.s});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Produtos", style: Constants.textoAppTitulo,),
        elevation: 0.0,
        actions: <Widget>[
          StreamBuilder<Object>(
            stream: _bloc.counter,
            builder: (context, data) {
              return Chip(
                label: Text(
                  (data.data ?? 0).toString(),
                  style: TextStyle(color: Colors.deepOrangeAccent),
                ),
              );
            },
          ),
          SizedBox(width: 20),
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
              color: Constants.colorIconsAppMenu,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: ProdutoSearchDelegate());
            },
          )
        ],
      ),
      body: ProdutoList(p: p, s: s,),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProdutoCreatePage()));
        },
      ),
    );
  }
}

