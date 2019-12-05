import 'package:flutter/material.dart';
import 'package:ofertasbv/src/arquivo/arquivo_page.dart';
import 'package:ofertasbv/src/categoria/categoria_page.dart';
import 'package:ofertasbv/src/pessoa/pessoa_page.dart';
import 'package:ofertasbv/src/produto/produto_tab.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';
import 'package:ofertasbv/src/sobre/sobre_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';
import 'package:ofertasbv/src/teste/leitor_codigo_barra.dart';
import 'package:ofertasbv/src/teste/mapa_principal.dart';

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: Stack(
        children: <Widget>[
          builderBodyBack(),
          menuLateral(context),
        ],
      ),
    );
  }

  builderBodyBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey[100],
            Colors.grey[100],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  ListView menuLateral(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 20, left: 10),
            height: 100,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "OFERTASBV",
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("ofertasbv.com.br"),
              ],
            )),
        ListTile(
          selected: true,
          leading: Icon(Icons.add_shopping_cart, color: Colors.black),
          title: Text("Produtos", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
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
          selected: true,
          leading: Icon(Icons.apps, color: Colors.black),
          title: Text("Categorias", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
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
          selected: true,
          leading: Icon(Icons.line_style, color: Colors.black),
          title: Text("SubCategorias", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
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
          selected: true,
          leading: Icon(Icons.add_alert, color: Colors.black),
          title: Text("Promoções", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
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
          selected: true,
          leading: Icon(Icons.local_convenience_store, color: Colors.black),
          title: Text("Mercados", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return PessoaPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.scanner, color: Colors.black),
          title: Text("Leitor códido de barra",
              style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return LeitorCodigoBarra();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.map, color: Colors.black),
          title: Text("Locais", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MapaPageApp();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.filter, color: Colors.black),
          title: Text("Arquivos", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ArquivoPage();
                },
              ),
            );
          },
        ),
        ListTile(
          selected: true,
          leading: Icon(Icons.error, color: Colors.black),
          title: Text("Sobre", style: TextStyle(color: Colors.black)),
          trailing: Icon(Icons.arrow_forward),
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
