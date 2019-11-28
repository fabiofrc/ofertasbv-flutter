import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_controller.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class SubcategoriaHome extends StatefulWidget {
  @override
  _SubcategoriaHomeState createState() => _SubcategoriaHomeState();
}

class _SubcategoriaHomeState extends State<SubcategoriaHome>
    with AutomaticKeepAliveClientMixin<SubcategoriaHome> {
  final _bloc = BlocProvider.getBloc<SubCategoriaController>();

  @override
  void initState() {
    _bloc.carregaSubcategorias();
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.carregaSubcategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: StreamBuilder(
        stream: _bloc.outController,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("não foi possivel buscar subcategorias"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<SubCategoria> subcategorias = snapshot.data;

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(subcategorias),
          );
        },
      ),
    );
  }

  ListView builderList(List<SubCategoria> subcategorias) {
    final urlArquivo = "http://192.168.1.3:8080/categorias/download/";
    final urlAsset = "assets/images/upload/default.jpg";

    return ListView.builder(
      itemCount: subcategorias.length,
      itemBuilder: (context, index) {
        SubCategoria s = subcategorias[index];
        return Card(
          margin: EdgeInsets.all(1),
          elevation: 0.0,
          child: ListTile(
            isThreeLine: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: s.arquivo != null
                  ? Image.network(
                      urlArquivo + s.arquivo,
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
            title: Text(s.nome, style: TextStyle(fontWeight: FontWeight.w600),),
            subtitle: Text(s.categoria.nome),
            trailing: Text("${s.id}"),
            onLongPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProdutoPage();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
