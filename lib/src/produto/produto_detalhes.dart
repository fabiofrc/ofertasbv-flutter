import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/const.dart';
import 'package:ofertasbv/src/api/constant_api.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/produto/produto_tab.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';

class ProdutoDetalhes extends StatefulWidget {
  Produto p;

  ProdutoDetalhes(this.p);

  @override
  _ProdutoDetalhesState createState() => _ProdutoDetalhesState();
}

class _ProdutoDetalhesState extends State<ProdutoDetalhes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Produto p = widget.p;

    return Scaffold(
      appBar: AppBar(
        title: Text(p.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(CupertinoIcons.search, color: Constants.colorIconsAppMenu,),
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
      padding: EdgeInsets.all(0),
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.2,
          child: p.arquivos.isNotEmpty
              ? Carousel(
                  autoplay: false,
                  dotBgColor: Colors.transparent,
                  images: p.arquivos.map((a) {
                    return NetworkImage(ConstantApi.urlArquivoProduto + a.foto);
                  }).toList())
              : Image.network(
                  ConstantApi.urlArquivoProduto + p.foto,
                  fit: BoxFit.fill,
                ),
        ),
        Card(
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListTile(
                  title: Text(
                    p.nome,
                    style: TextStyle(fontSize: 20, color: Colors.grey[900]),
                  ),
                ),
                ListTile(
                  title: Text(
                    p.unidade,
                    style: TextStyle(fontSize: 20, color: Colors.grey[900]),
                  ),
                  trailing: Text(
                    "R\$ ${p.valorUnitario}",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton.icon(
                      label: Text(
                        "Ir para Produtos",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      color: Colors.orangeAccent,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ProdutoTab();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RaisedButton.icon(
                      label: Text(
                        "Ir para Ofertas",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      color: Colors.blue[900],
                      elevation: 0.0,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PromocaoPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 0.0,
          child: Container(
            color: Colors.transparent,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Código: ${p.id}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  "${p.descricao}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        )
      ],
    );
  }
}
