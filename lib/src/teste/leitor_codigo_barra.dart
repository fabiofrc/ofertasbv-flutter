import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:link/link.dart';

class LeitorCodigoBarra extends StatefulWidget {
  @override
  _LeitorCodigoBarraState createState() => new _LeitorCodigoBarraState();
}

class _LeitorCodigoBarraState extends State<LeitorCodigoBarra> {
  String barcode = "";
  Produto _produto = Produto();
  var codigoBarraController = TextEditingController();

  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _executar(String nomeAudio) {
    _audioCache.play(nomeAudio + ".mp3");
  }

  @override
  initState() {
    super.initState();
    _audioCache.loadAll(["beep-07.mp3"]);
  }

  File galleryFile;

  imageSelectorGallery() async {
    galleryFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      // maxHeight: 50.0,
      // maxWidth: 50.0,
    );
    print("You selected gallery image : " + galleryFile.path);
    setState(() {});
  }

  Controller controller;

  @override
  void didChangeDependencies() {
    controller = Controller();
    super.didChangeDependencies();
  }

  void _showErrorSnackBar() {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Oops... the URL couldn\'t be opened!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _produto.codigoBarra = barcode;
    print("construindo tela: " + _produto.codigoBarra);
    return Scaffold(
      appBar: AppBar(
        title: Text('Leitor código'),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: codigoBarraController,
                    decoration: InputDecoration(
                      labelText: "Codigo de barra",
                      hintText: "Digite o código de barra",
                    ),
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
                  Link(
                    child: Text(
                      barcode,
                      style: TextStyle(color: Colors.blue),
                    ),
                    url: barcode,
                    onError: _showErrorSnackBar,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget displayImage() {
    return new SizedBox(
      height: 300.0,
      width: 400.0,
      child: galleryFile == null
          ? Text('Sorry nothing to display')
          : Image.file(galleryFile),
    );
  }

  _getDateNow() {
    var now = new DateTime.now();
    var formatter = new DateFormat('MM-dd-yyyy H:mm');
    return formatter.format(now);
  }

// Method for scanning barcode....
  Future barcodeScanning() async {
    //imageSelectorGallery();
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        _executar("beep-07");
        this.barcode = barcode;
        codigoBarraController.text = this.barcode;
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'Permissão negada!';
        });
      } else {
        setState(() => this.barcode = 'Ops! erro: $e');
      }
    } on FormatException {
      setState(() => this.barcode = 'Nada capturado.');
    } catch (e) {
      setState(() => this.barcode = 'Erros: $e');
    }
  }
}

class BarraCode extends StatefulWidget {
  Produto _produto;

  BarraCode(this._produto);

  @override
  _BarraCodeState createState() => _BarraCodeState();
}

class _BarraCodeState extends State<BarraCode> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(""),
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
