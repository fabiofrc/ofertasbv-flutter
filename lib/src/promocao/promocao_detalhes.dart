import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_list.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';

class PromocaoDetalhes extends StatefulWidget {
  Promocao p;

  PromocaoDetalhes(this.p);

  @override
  _PromocaoDetalhesState createState() => _PromocaoDetalhesState();
}

class _PromocaoDetalhesState extends State<PromocaoDetalhes> {
  var selectedCard = 'WEIGHT';
  final _bloc = BlocProvider.getBloc<PromocaoController>();

  final urlArquivo = "http://192.168.1.3:8080/promocoes/download/";

  @override
  void initState() {
    urlArquivo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Promocao p = widget.p;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ofertas detalhes"),
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

  buildContainer(Promocao p) {
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
                  "Promoção: ${p.nome}",
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
                  "Desconto: ${p.desconto} %",
                  style: TextStyle(
                    color: Colors.green[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                RaisedButton.icon(
                  label: Text("Ir para produtos", style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.search,color: Colors.white,),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProdutoPage(p: p);
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
