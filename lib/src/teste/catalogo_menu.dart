import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/categoria/categoria_page.dart';
import 'package:ofertasbv/src/pessoa/pessoa_page.dart';
import 'package:ofertasbv/src/produto/produto_tab.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';
import 'package:ofertasbv/src/teste/geo_code.dart';
import 'package:ofertasbv/src/teste/mapa_principal.dart';

import 'leitor_codigo_barra.dart';
import 'mapa_localization.dart';

class CatalogoMenu extends StatefulWidget {
  @override
  _CatalogoMenuState createState() => _CatalogoMenuState();
}

class _CatalogoMenuState extends State<CatalogoMenu> {
  PageController _pageController;
  int _page = 0;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    double altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalogo"),
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          _builderBodyBack(),
          buildGridView(context),
        ],
      ),
    );
  }

  Widget _builderBodyBack() => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.grey[200],
              Colors.grey[100],
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      );

  GridView buildGridView(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 3,
      //childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTab();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.shopping_cart, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Produto",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage();
                },
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.apps, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Categoria",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add_alert, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Oferta",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PessoaPage();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.location_city, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Mercado",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PessoaPage();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.people, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Cliente",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubcategoriaPage();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.line_style, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "SubCategoria",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MapaPageApp();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.location_on, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Mapa",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return GeoCode();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.add_location, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "GeoCode",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.scanner, color: Colors.deepOrange, size: 30,),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Scanner",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
