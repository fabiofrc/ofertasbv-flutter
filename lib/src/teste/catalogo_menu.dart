import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/categoria/categoria_page.dart';
import 'package:ofertasbv/src/home/home.dart';
import 'package:ofertasbv/src/pessoa/pessoa_page.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/produto/produto_tab.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';
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
        title: Text("Catalogo app"),
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
          ),

          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ],
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
              Colors.grey[100],
              Colors.grey[200],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      );

  GridView buildGridView(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(top: 40),
      crossAxisSpacing: 10,
      mainAxisSpacing: 30,
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Produto",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.apps,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Categoria",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add_alert,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Oferta",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_city,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Mercado",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.people,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Cliente",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.line_style,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "SubCategoria",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.location_on,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Mapa",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PainelEndereco();
                },
              ),
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add_location,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "GeoCode",
                style: TextStyle(color: Colors.blue[900]),
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
                  //border: Border.all(color: Colors.grey[300]),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.scanner,
                  color: Colors.blue[900],
                  size: 30,
                ),
                padding: EdgeInsets.all(30),
              ),
              Text(
                "Scanner",
                style: TextStyle(color: Colors.blue[900]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
