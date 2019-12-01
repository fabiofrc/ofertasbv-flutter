import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';

class CategoriaList extends StatefulWidget {
  @override
  _CategoriaListState createState() => _CategoriaListState();
}

class _CategoriaListState extends State<CategoriaList>
    with AutomaticKeepAliveClientMixin<CategoriaList> {
  final _bloc = BlocProvider.getBloc<CategoriaController>();

  final urlArquivo = "http://192.168.1.3:8080/categorias/download/";
  final urlAsset = "assets/images/upload/default.jpg";

  @override
  void initState() {
    _bloc.carregaCategorias();
    urlArquivo;
    urlAsset;
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.carregaCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: StreamBuilder(
        stream: _bloc.outController,
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
            child: builderList(categorias),
          );
        },
      ),
    );
  }

  ListView builderList(List<Categoria> categorias) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        Categoria c = categorias[index];

        return Card(
          margin: EdgeInsets.all(1),
          elevation: 0.0,
          child: ListTile(
            isThreeLine: true,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: c.arquivo != null
                  ? Image.network(
                      urlArquivo + c.arquivo,
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
            title: Text(c.nome, style: TextStyle(fontWeight: FontWeight.w600),),
            subtitle: Text("${c.dataRegistro}"),
            trailing: Text("${c.id}"),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SubcategoriaPage(c: c,);
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
