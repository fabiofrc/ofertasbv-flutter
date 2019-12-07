import 'package:evil_icons_flutter/evil_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ofertasbv/const.dart';
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
                  style: TextStyle(color: Colors.blue[900]),
                ),
                Text("ofertasbv.com.br"),
              ],
            )),
        ListTile(
          selected: true,
          leading: Icon(CupertinoIcons.shopping_cart, color: Colors.black),
          title: Text("Produtos", style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.create, color: Colors.black),
          title: Text("Categorias", style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.create_solid, color: Colors.black),
          title: Text("SubCategorias", style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.game_controller, color: Colors.black),
          title: Text("Ofertas", style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.home, color: Colors.black),
          title: Text("Lojas", style: Constants.textoDrawerTitulo,),
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
          leading: Icon(FontAwesomeIcons.barcode, color: Colors.black),
          title: Text("Leitor códido de barra",
            style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.location, color: Colors.black),
          title: Text("Locais",  style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.photo_camera, color: Colors.black),
          title: Text("Arquivos",  style: Constants.textoDrawerTitulo,),
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
          leading: Icon(CupertinoIcons.info, color: Colors.black),
          title: Text("Sobre",  style: Constants.textoDrawerTitulo,),
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
