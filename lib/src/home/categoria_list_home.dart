import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/api/constant_api.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_create_page.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';

class CategoriaListHome extends StatefulWidget {
  @override
  _CategoriaListHomeState createState() => _CategoriaListHomeState();
}

class _CategoriaListHomeState extends State<CategoriaListHome>
    with AutomaticKeepAliveClientMixin<CategoriaListHome> {
  final _bloc = BlocProvider.getBloc<CategoriaController>();

  @override
  void initState() {
    _bloc.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.getAll();
  }

  showDialogAlert(BuildContext context, Categoria p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Categoria'),
          content: Text(p.nome),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('EDITAR'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CategoriaCreatePage();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
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
            child: builderListCategorias(categorias),
          );
        },
      ),
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
            margin: EdgeInsets.only(left: 10),
            elevation: 1,
            child: AnimatedContainer(
              duration: Duration(seconds: 4),
              width: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: Image.network(
                        ConstantApi.urlArquivoCategoria + c.foto,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(c.nome.toLowerCase(), style: TextStyle(fontSize: 12),),
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
