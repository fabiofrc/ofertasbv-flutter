import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/pessoa/pessoa_controller.dart';
import 'package:ofertasbv/src/pessoa/pessoa_create_page.dart';
import 'package:ofertasbv/src/pessoa/pessoa_detalhes.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';

class PessoaList extends StatefulWidget {
  @override
  _PessoaListState createState() => _PessoaListState();
}

class _PessoaListState extends State<PessoaList>
    with AutomaticKeepAliveClientMixin<PessoaList> {
  final _bloc = BlocProvider.getBloc<PessoaController>();

  var tipoPessoaFisica = "PESSOAFISICA";
  var tipoPessoaJuridica = "PESSOAJURIDICA";

  final urlArquivo = "http://192.168.1.3:8080/pessoas/download/";
  final urlAsset = "assets/images/upload/default.jpg";

  @override
  void initState() {
    _bloc.getAll();
    urlArquivo;
    urlAsset;
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.getAll();
  }

  showDialogAlert(BuildContext context, Pessoa p) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização'),
          content: Text(p.nome + " - " + p.endereco.logradouro),
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
                      return PessoaCreatePage();
                    },
                  ),
                );
              },
            ),
            FlatButton(
              child: const Text('DETALHES'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return PessoaDetalhes(p);
                    },
                  ),
                );
              },
            )
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
              child: Text("não foi possivel buscar pessoas"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Pessoa> pessoas = snapshot.data;

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(pessoas),
          );
        },
      ),
    );
  }

  ListView builderList(List<Pessoa> pessoas) {
    return ListView.builder(
      itemCount: pessoas.length,
      itemBuilder: (context, index) {
        Pessoa p = pessoas[index];
        return Card(
          margin: EdgeInsets.all(1),
          elevation: 0.0,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: p.arquivo != null
                  ? Image.network(
                      urlArquivo + p.arquivo,
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
            title: Text(
              p.nome,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(p.endereco.logradouro + ", " + p.endereco.numero),
            trailing: Text("${p.id}"),
            onTap: () {
              showDialogAlert(context, p);
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
