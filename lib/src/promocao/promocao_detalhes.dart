import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
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

  @override
  void initState() {
    _bloc.carregaPromocoes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String preco = p.valorUnitario.toStringAsFixed(2);
    final urlArquivo = "http://192.168.1.3:8080/produtos/download/";
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text("Promoção detalhes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProdutoSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                urlArquivo + widget.p.arquivo,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(
                    widget.p.nome,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle:
                      Text(widget.p.descricao, style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("De ${widget.p.dataInicio}" ,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                Text(" á ", style: TextStyle(fontSize: 18)),
                Text("${widget.p.dataFinal}", style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("Desconto de",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  subtitle: Text("Enquanto durar o estque",
                      style: TextStyle(fontSize: 18)),
                  trailing: Text("${widget.p.desconto} %",
                      style: TextStyle(color: Colors.green[700], fontSize: 30)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> onRefresh() {
    return _bloc.carregaPromocoes();
  }

  ListView builderList(List<Produto> produtos) {
    final urlArquivo = "http://192.168.1.3:8080/promocoes/download/";
    final urlAsset = "asset/images/upload/default.jpg";

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];
        return ListTile(
          isThreeLine: true,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: p.arquivo != null
                ? Image.network(
                    urlArquivo + p.arquivo,
                    height: 200,
                    width: 80,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    urlAsset,
                    height: 200,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
          ),
          title: Text(p.nome),
          subtitle: Text(p.subCategoria.nome),
          trailing: Text(
            "R\$ ${p.valorUnitario}",
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
