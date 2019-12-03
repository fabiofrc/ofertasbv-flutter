import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:ofertasbv/src/categoria/categoria_page.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_detalhes.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_detalhes.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';

class CatalogoHome extends StatefulWidget {
  @override
  _CatalogoHomeState createState() => _CatalogoHomeState();
}

class _CatalogoHomeState extends State<CatalogoHome>{
  final _blocCategoria = BlocProvider.getBloc<CategoriaController>();
  final _blocProduto = BlocProvider.getBloc<ProdutoController>();
  final _blocPromocao = BlocProvider.getBloc<PromocaoController>();

  final urlArquivoCategoria = "http://192.168.1.3:8080/categorias/download/";
  final urlArquivoProduto = "http://192.168.1.3:8080/produtos/download/";
  final urlArquivoOfertas = "http://192.168.1.3:8080/promocaoes/download/";

  final urlAsset = "assets/images/upload/default.jpg";

  @override
  void initState() {
    _blocCategoria.getAll();
    _blocProduto.getAll();
    _blocPromocao.getAll();
    super.initState();
  }

  // ignore: missing_return
  Future<void> onRefresh() {
    _blocCategoria.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(5),
      children: <Widget>[
        SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Categorias",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            FlatButton(
              child: Text(
                "Veja mais",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CategoriaPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        Container(
          color: Colors.transparent,
          height: 100,
          child: StreamBuilder(
            stream: _blocCategoria.outController,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("não foi possivel buscar categorias"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              List<Categoria> categorias = snapshot.data;

              return RefreshIndicator(
                onRefresh: onRefresh,
                child: builderListCategorias(categorias),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Produtos",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            FlatButton(
              child: Text(
                "Veja mais",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        Container(
          height: 250,
          child: StreamBuilder(
            stream: _blocProduto.outController,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("não foi possivel buscar produtos"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Produto> produtos = snapshot.data;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: builderListProdutos(produtos),
              );
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Promoções",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            FlatButton(
              child: Text(
                "Veja mais",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
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
        Container(
          color: Colors.transparent,
          height: 250,
          child: StreamBuilder(
            stream: _blocPromocao.outController,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("não foi possivel buscar promoções"),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              List<Promocao> promocoes = snapshot.data;
              return RefreshIndicator(
                onRefresh: onRefresh,
                child: builderListPromocoes(promocoes),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  ListView builderListCategorias(List<Categoria> categorias) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        Categoria c = categorias[index];

        return GestureDetector(
          child: Card(
            color: Colors.transparent,
            margin: EdgeInsets.only(left: 5),
            elevation: 0.0,
            child: Container(
              width: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        urlArquivoProduto + c.arquivo,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(c.nome),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubcategoriaPage(c: c,);
                },
              ),
            );
          },
        );
      },
    );
  }

  ListView builderListProdutos(List<Produto> produtos) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];

        return GestureDetector(
          child: Card(
            margin: EdgeInsets.only(left: 5),
            elevation: 0.0,
            child: Container(
              width: 150,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        urlArquivoProduto + p.arquivo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(p.nome, style: TextStyle(fontWeight: FontWeight.w500),),
                          Text(
                            "R\$ ${p.valorUnitario}",
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhes(p);
                },
              ),
            );
          },
        );
      },
    );
  }

  ListView builderListPromocoes(List<Promocao> promocoes) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return GestureDetector(
          child: Card(
            margin: EdgeInsets.only(left: 5),
            elevation: 0.0,
            child: Container(
              width: 150,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        urlArquivoProduto + p.arquivo,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(p.nome, style: TextStyle(fontWeight: FontWeight.w500),),
                          Text(
                            "% OFF ${p.desconto}",
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoDetalhes(p);
                },
              ),
            );
          },
        );
      },
    );
  }

}
