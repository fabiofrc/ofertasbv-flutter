import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ofertasbv/src/promocao/promocao_api_provider.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:intl/intl.dart';

class PromocaoCreatePage extends StatefulWidget {
  @override
  _PromocaoCreatePageState createState() => _PromocaoCreatePageState();
}

class _PromocaoCreatePageState extends State<PromocaoCreatePage> {
  final _bloc = BlocProvider.getBloc<PromocaoController>();
  final _promocao = Promocao();

  DateTime dataAtual = DateTime.now();
  String _valor;
  String valorSlecionado;
  File file;

  @override
  void initState() {
    _bloc.getAll();
    super.initState();
  }

  @override
  void dispose() {
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
      _promocao.arquivo = file.path.split('/').last;
      print(" upload de arquivo : $_promocao.arquivo");
    });
  }

  void _onClickUpload() async {
    if (file != null) {
      var url = await PromocaoApiProvider.upload(file, _promocao.arquivo);
    }
  }

  @override
  Widget build(BuildContext context) {
    //NumberFormat formatter = NumberFormat("00.00");
    //_promocao.desconto = num.parse(0.18941.toStringAsPrecision(2));

    var formatadorNumber = NumberFormat("#.0#", "pt_BR");
    //var resultado = formatadorNumber.format(_promocao.desconto);

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text("Promoção cadastro"),
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
                                  onSaved: (value) => _promocao.nome = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Título",
                                    hintText: "título promoção",
                                    prefixIcon: Icon(Icons.edit),
                                  ),
                                  keyboardType: TextInputType.text,
                                  maxLength: 100,
                                  maxLines: 3,
                                ),
                                TextFormField(
                                  onSaved: (value) =>
                                      _promocao.descricao = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Descrição",
                                    hintText: "descrição promoção",
                                    prefixIcon: Icon(Icons.description),
                                  ),
                                  maxLength: 100,
                                  maxLines: 3,
                                  keyboardType: TextInputType.text,
                                ),
                                TextFormField(
                                  onSaved: (value) =>
                                      _promocao.desconto = double.parse(value),
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Desconto",
                                    hintText: "desconto promoção",
                                    prefixIcon: Icon(Icons.monetization_on),
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
//                            inputFormatters: [
//                              MaskedTextInputFormatter(
//                                  mask: '0.0', separator: '.')
//                            ],
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  onSaved: (value) =>
                                      _promocao.dataInicio = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Início",
                                    hintText: "inicício promoção",
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                  keyboardType: TextInputType.datetime,
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  onSaved: (value) =>
                                      _promocao.dataFinal = value,
                                  validator: (value) =>
                                      value.isEmpty ? "campo obrigário" : null,
                                  decoration: InputDecoration(
                                    labelText: "Encerramento",
                                    hintText: "encerramento promoção",
                                    prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                  keyboardType: TextInputType.datetime,
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
                                SizedBox(height: 15),
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
                                _promocao.arquivo != null
                                    ? Text("${_promocao.arquivo}")
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
                        _promocao.dataRegistro = dateFormat.format(dataAgora);
                        _bloc.promocaoIn.add(_promocao);
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
