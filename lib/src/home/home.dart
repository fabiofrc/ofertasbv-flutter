import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/arquivo/arquivo_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/home/catalogo_home.dart';
import 'package:ofertasbv/src/home/drawer_list.dart';
import 'package:ofertasbv/src/pessoa/pessoa_controller.dart';
import 'package:ofertasbv/src/pessoa/pessoa_list.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_grid.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_list.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_controller.dart';
import 'package:ofertasbv/src/teste/catalogo_app.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {

  int elementIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => ProdutoController()),
        Bloc((i) => CategoriaController()),
        Bloc((i) => SubCategoriaController()),
        Bloc((i) => PromocaoController()),
        Bloc((i) => PessoaController()),
        Bloc((i) => ArquivoController()),
      ],
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            primary: true,
            bottomOpacity: 1.0,
            title: Text("OFERTASBV"),
            elevation: 0.0,
            centerTitle: false,
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
                icon: Icon(Icons.apps),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CatalogoApp()));
                },
              ),
            ],
            bottom: TabBar(
              labelColor: Colors.orangeAccent,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  text: "HOME",
                  //icon: Icon(Icons.home),
                ),

                Tab(
                  text: "PRODUTO",
                  //icon: Icon(Icons.shopping_cart),
                ),

                Tab(
                  text: "OFERTAS",
                  //icon: Icon(Icons.add_alert),
                ),
                Tab(
                  text: "LOJAS",
                  //icon: Icon(Icons.location_city),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              CatalogoHome(),
              ProdutoGrid(),
              PromocaoList(),
              PessoaList(),
            ],
          ),
          

/* ======================= Menu lateral ======================= */
          drawer: DrawerList(),
/* ======================= Botão Flutuante ======================= */


        ),
      ),
    );
  }
  void onBarTapItem(int value) {
    setState(() {
      elementIndex = value;
    });
  }
}
