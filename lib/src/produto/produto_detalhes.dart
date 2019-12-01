
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';

class ProdutoDetalhes extends StatefulWidget {
  Produto p;

  ProdutoDetalhes(this.p);

  @override
  _ProdutoDetalhesState createState() => _ProdutoDetalhesState();
}

class _ProdutoDetalhesState extends State<ProdutoDetalhes> {

  final urlArquivo = "http://192.168.1.3:8080/produtos/download/";

  @override
  void initState() {
    urlArquivo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Produto p = widget.p;

    return Scaffold(
      appBar: AppBar(
        title: Text("Produto detalhes"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProdutoSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: buildContainer(p),
    );
  }

  buildContainer(Produto p) {
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            urlArquivo + p.arquivo,
            fit: BoxFit.fill,
          ),
        ),

        Card(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Código: ${p.id}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Produto: ${p.nome}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Descrição: ${p.descricao}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Valor: R\$ ${p.valorUnitario}",
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}