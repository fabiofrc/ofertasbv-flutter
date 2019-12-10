import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ofertasbv/const.dart';
import 'package:ofertasbv/src/api/constant_api.dart';
import 'categoria_api_provider.dart';
import 'categoria_controller.dart';
import 'categoria_model.dart';
import 'package:intl/intl.dart';

class CategoriaCreatePage extends StatefulWidget {

  @override
  _CategoriaCreatePageState createState() => _CategoriaCreatePageState();
}

class _CategoriaCreatePageState extends State<CategoriaCreatePage> {
  final _bloc = BlocProvider.getBloc<CategoriaController>();
  Categoria categoria = Categoria();
  File file;

  var controllerNome = TextEditingController();

  @override
  void initState() {
    _bloc.getAll();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  void _onClickFoto() async {
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      this.file = f;
      categoria.foto = file.path.split('/').last;
      print(" upload de arquivo : ${categoria.foto}");
    });
  }

  void _onClickUpload() async {
    if (file != null) {
      var url = await CategoriaApiProvider.upload(file, categoria.foto);
    }
  }

  void showToast(String msg, {int duration, int gravity}) {
    //Toast.show(msg, context, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    //controllerNome.text = c.nome;

    return Scaffold(
      appBar: AppBar(
        title: Text("Categoria cadastros"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_upload, color: Constants.colorIconsAppMenu,),
            onPressed: _onClickUpload,
          )
        ],
      ),
      body: StreamBuilder<int>(
        stream: _bloc.responseOut,
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
                                  onSaved: (value) => categoria.nome = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    hintText: "nome categoria",
                                    prefixIcon: Icon(Icons.edit),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 50,
                                  maxLines: 2,
                                  //initialValue: c.nome,
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
                                    "Ir para geleria de foto",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  elevation: 0.0,
                                  onPressed: _onClickFoto,
                                ),
                                SizedBox(height: 15),
                                file != null
                                    ? Image.file(file,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill)
                                    : Image.asset(
                                        ConstantApi.urlAsset,
                                        height: 100,
                                        width: 100,
                                      ),
                                SizedBox(height: 15),
                                categoria.foto != null
                                    ? Text("${categoria.foto}")
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
                        categoria.dataRegistro = dateFormat.format(dataAgora);
                        _bloc.categoriaIn.add(categoria);
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
