import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_controller.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_create_page.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_list.dart';

class SubcategoriaPage extends StatefulWidget {

  Categoria c;
  SubcategoriaPage({Key key, this.c}) : super(key: key);

  @override
  _SubcategoriaPageState createState() => _SubcategoriaPageState(c:this.c);
}

class _SubcategoriaPageState extends State<SubcategoriaPage> {
  final _bloc = BlocProvider.getBloc<SubCategoriaController>();

  Categoria c;
  _SubcategoriaPageState({this.c});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subcategorias"),
        elevation: 0.0,
        actions: <Widget>[
          StreamBuilder<Object>(
            stream: _bloc.counter,
            builder: (context, data) {
              return Chip(
                label: Text(
                  (data.data ?? 0).toString(),
                  style: TextStyle(color: Colors.white70),
                ),
              );
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SubcategoriaList(c: c,),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 8,
            height: 8,
          ),
          FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubCategoriaCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
