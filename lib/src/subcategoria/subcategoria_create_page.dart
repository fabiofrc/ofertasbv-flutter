import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/categoria/categoria_controller.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_api_provider.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_controller.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class SubCategoriaCreatePage extends StatefulWidget {
  @override
  _SubCategoriaCreatePageState createState() => _SubCategoriaCreatePageState();
}

class _SubCategoriaCreatePageState extends State<SubCategoriaCreatePage> {
  final _blocSubCategoria = BlocProvider.getBloc<SubCategoriaController>();

  CategoriaController _blocCategoria =
      BlocProvider.getBloc<CategoriaController>();

  SubCategoria _subCategoria = SubCategoria();
  Categoria _categoriaSelecionada;

  Controller controller;

  File file;

  @override
  void initState() {
    _blocCategoria.getAll();
    super.initState();
  }

  @override
  void dispose() {
    _blocCategoria.dispose();
    _blocSubCategoria.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  void _onClickFoto() async {
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.file = f;
      _subCategoria.arquivo = file.path.split('/').last;
      print(" upload de arquivo : ${_subCategoria.arquivo}");
    });
  }

  void _onClickUpload() async {
    if (file != null) {
      var url =
          await SubcategoriaApiProvider.upload(file, _subCategoria.arquivo);
    }
  }

  @override
  Widget build(BuildContext context) {
    _subCategoria.categoria = _categoriaSelecionada;
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text("SubCategoria cadastros"),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: _onClickUpload,
          )
        ],
      ),
      body: StreamBuilder<int>(
        stream: _blocSubCategoria.responseOut,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
                child:
                    Text("${snapshot.error}", style: TextStyle(fontSize: 25)));

          if (snapshot.hasData) {
            if (snapshot.data == 0) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              Timer(Duration(seconds: 1), () {
                Navigator.pop(context);
              });
              return Center(
                  child: Text(
                "Inserido com sucesso!",
                style: TextStyle(fontSize: 25),
              ));
            }
          } else {
            return ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    autovalidate: true,
                    key: controller.formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  onSaved: (value) =>
                                      _subCategoria.nome = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    hintText: "nome subcategoria",
                                    prefixIcon: Icon(Icons.edit),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                StreamBuilder(
                                  stream: _blocCategoria.outController,
                                  builder: (context, snapshot) {
                                    List<Categoria> categorias = snapshot.data;
                                    if (categorias != null) {
                                      return DropdownButtonFormField<Categoria>(
                                        hint: Text('Selecione categoria...'),
                                        // ignore: unrelated_type_equality_checks
                                        value: _categoriaSelecionada == ""
                                            ? null
                                            : _categoriaSelecionada,
                                        items: categorias
                                            .map((Categoria categoria) {
                                          return DropdownMenuItem<Categoria>(
                                            value: categoria,
                                            child: Text(categoria.nome),
                                          );
                                        }).toList(),
                                        onChanged: changeCategorias,
                                      );
                                    } else {
                                      return Container(
                                        decoration: new BoxDecoration(
                                            color: Colors.white),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                RaisedButton.icon(
                                  icon: Icon(Icons.picture_in_picture),
                                  label: Text(
                                    "Ir para galeria de foto",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  elevation: 0.0,
                                  onPressed: _onClickFoto,
                                ),
                                SizedBox(height: 20),
                                file != null
                                    ? Image.file(file,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill)
                                    : Image.asset(
                                        "assets/images/upload/upload.jpg",
                                        height: 100,
                                        width: 100,
                                      ),
                                SizedBox(height: 15),
                                _subCategoria.arquivo != null
                                    ? Text("${_subCategoria.arquivo}")
                                    : Text("sem arquivo"),
                                RaisedButton.icon(
                                  icon: Icon(Icons.file_upload),
                                  label: Text(
                                    "Anexar foto de capa",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  elevation: 0.0,
                                  onPressed: _onClickUpload,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: RaisedButton(
                    child: Text(
                      "Enviar",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (controller.validate()) {
                        DateTime dataAgora = DateTime.now();
                        _subCategoria.dataRegistro =
                            dateFormat.format(dataAgora);
                        _blocSubCategoria.subCategoriaIn.add(_subCategoria);
                      }
                    },
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  void changeCategorias(Categoria c) {
    setState(() {
      _categoriaSelecionada = c;
      print("CAT.:  ${_categoriaSelecionada.id}");
    });
  }
}

class Controller {
  var formKey = GlobalKey<FormState>();

  bool validate() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else
      return false;
  }
}
