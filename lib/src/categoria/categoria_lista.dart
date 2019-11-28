import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categoria_bloc.dart';

class CategoriaLista extends StatefulWidget {
  @override
  _CategoriaListaState createState() => _CategoriaListaState();
}

class _CategoriaListaState extends State<CategoriaLista> {
  @override
  Widget build(BuildContext context) {
    CategoriaBloc bloc = Provider.of<CategoriaBloc>(context);
    return Container();
  }
}
