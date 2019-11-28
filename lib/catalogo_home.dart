//
//import 'dart:async';
//
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:ofertasbv/src/categoria/categoria_api_provider.dart';
//import 'package:ofertasbv/src/categoria/categoria_model.dart';
//import 'package:ofertasbv/src/categoria/categoria_page.dart';
//import 'package:ofertasbv/src/produto/produto_api_provider.dart';
//import 'package:ofertasbv/src/produto/produto_model.dart';
//import 'package:ofertasbv/src/produto/produto_page.dart';
//import 'package:ofertasbv/src/promocao/promocao_api_provider.dart';
//import 'package:ofertasbv/src/promocao/promocao_model.dart';
//
//class CatalohoHome extends StatefulWidget {
//  @override
//  _CatalohoHomeState createState() => _CatalohoHomeState();
//}
//
//class _CatalohoHomeState extends State<CatalohoHome> {
//
//  final _streamControllerCategoria = StreamController<List<Categoria>>();
//  carregaCategorias() async {
//    List<Categoria> categorias = await CategoriaApiProvider.getAll();
//    _streamControllerCategoria.add(categorias);
//  }
//
//  final _streamControllerProduto = StreamController<List<Produto>>();
//  carregaProdutos() async {
//    List<Produto> produtos = await ProdutoApiProvider.getAll();
//    _streamControllerProduto.add(produtos);
//  }
//
//  final _streamControllerPromocao = StreamController<List<Promocao>>();
//  carregaPromocoes() async {
//    List<Promocao> promocoes = await PromocaoApiProvider.getAll();
//    _streamControllerPromocao.add(promocoes);
//  }
//
//  @override
//  void initState() {
//    carregaCategorias();
//    carregaProdutos();
//    carregaPromocoes();
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final TextEditingController _searchControl = new TextEditingController();
//
//
//    return ListView(
//      padding: EdgeInsets.all(10),
//      children: <Widget>[
//        SizedBox(height: 2),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Text(
//              "Categorias",
//              style: TextStyle(
//                fontSize: 23,
//                fontWeight: FontWeight.w800,
//              ),
//            ),
//            FlatButton(
//              child: Text(
//                "Veja mais",
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//              ),
//              onPressed: () {
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (BuildContext context) {
//                      return CategoriaPage();
//                    },
//                  ),
//                );
//              },
//            ),
//          ],
//        ),
//        Container(
//          height: 120,
//          child: StreamBuilder(
//
//          ),
//        ),
//        SizedBox(height: 20),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Text(
//              "Produtos Popular",
//              style: TextStyle(
//                fontSize: 23,
//                fontWeight: FontWeight.w800,
//              ),
//            ),
//            FlatButton(
//              child: Text(
//                "Veja mais",
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//              ),
//              onPressed: () {
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (BuildContext context) {
//                      return ProdutoPage();
//                    },
//                  ),
//                );
//              },
//            ),
//          ],
//        ),
//        Container(
//          height: 230,
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            shrinkWrap: true,
//            itemCount: produtos.length,
//            itemBuilder: (BuildContext context, int index) {
//              Produto p = produtos[index];
//              String preco = p.preco.toStringAsFixed(2);
//              return Padding(
//                padding: EdgeInsets.only(right: 10),
//                child: GestureDetector(
//                  onTap: () {
//                    Navigator.of(context).push(
//                      MaterialPageRoute(
//                        builder: (BuildContext context) {
//                          return ProdutoDetalhes();
//                        },
//                      ),
//                    );
//                  },
//                  child: Container(
//                    color: Colors.white,
//                    height: 150,
//                    width: 165,
//                    child: Column(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        Text(
//                          p.nome,
//                          style: TextStyle(
//                            color: Colors.black26,
//                            fontWeight: FontWeight.bold,
//                            fontSize: 18,
//                          ),
//                        ),
//                        SizedBox(height: 10),
//                        ClipRRect(
//                          borderRadius: BorderRadius.circular(15),
//                          child: Image.asset(
//                            p.arquivo,
//                            height: 150,
//                            width: 150,
//                            fit: BoxFit.cover,
//                          ),
//                        ),
//                        Center(
//                          child: Text(
//                            "R\$ " + preco,
//                            style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 25,
//                              fontWeight: FontWeight.w500,
//                            ),
//                          ),
//                        )
//                      ],
//                    ),
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//        SizedBox(height: 10),
//        Row(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          children: <Widget>[
//            Text(
//              "Promoções",
//              style: TextStyle(
//                fontSize: 23,
//                fontWeight: FontWeight.w800,
//              ),
//            ),
//            FlatButton(
//              child: Text(
//                "Veja mais",
//                style: TextStyle(
//                  color: Colors.grey,
//                ),
//              ),
//              onPressed: () {
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (BuildContext context) {
//                      return PromocaoPage();
//                    },
//                  ),
//                );
//              },
//            ),
//          ],
//        ),
//        Container(
//          height: 200,
//          child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            shrinkWrap: true,
//            itemCount: promocoes.length,
//            itemBuilder: (BuildContext context, int index) {
//              PromocaoModel p = promocoes[index];
//              String preco = p.valor.toStringAsFixed(2);
//              return Padding(
//                padding: EdgeInsets.only(right: 10),
//                child: GestureDetector(
//                  onTap: () {},
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        height: 180,
//                        width: 340,
//                        color: Colors.white,
//                        child: ClipRRect(
//                          borderRadius: BorderRadius.circular(15),
//                          child: Image.asset(
//                            p.arquivo,
//                            height: 180,
//                            width: 340,
//                            fit: BoxFit.cover,
//                          ),
//                        ),
//                      ),
//                      Text(p.titulo),
//                    ],
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//        SizedBox(height: 10),
//      ],
//    );
//  }
//}
