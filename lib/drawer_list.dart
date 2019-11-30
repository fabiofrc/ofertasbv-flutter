import 'package:flutter/material.dart';
import 'package:ofertasbv/src/categoria/categoria_page.dart';
import 'package:ofertasbv/src/produto/produto_grid.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/produto/produto_tab.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';
import 'package:ofertasbv/src/sobre/sobre_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          //_builderBodyBack(),
          menuLateral(context),
        ],
      ),
    );
  }

  Widget _builderBodyBack() => Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 250, 10, 5),
          Color.fromARGB(255, 150, 20, 10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  );

  ListView menuLateral(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("OFERTASBV"),
          accountEmail: Text("www.ofertasbv.com.br"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: AssetImage("assets/images/categorias/ofertasbv.png"),
          ),
        ),
        ListTile(
          leading: Icon(Icons.add_shopping_cart, color: Colors.black),
          title: Text("Produtos", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.pop(context);
//          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoTab();
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.apps, color: Colors.black),
          title: Text("Categorias", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.pop(context);
//          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return CategoriaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.line_style, color: Colors.black),
          title: Text("SubCategorias", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.pop(context);
//          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubcategoriaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.add_alert, color: Colors.black),
          title: Text("Promoções", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.pop(context);
//          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PromocaoPage();
                },
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.error, color: Colors.black),
          title: Text("Sobre", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
//          onTap: () {
//            Navigator.pop(context);
//          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SobrePage();
                },
              ),
            );
          },
        )
      ],
    );
  }
}
