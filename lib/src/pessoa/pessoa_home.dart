import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/pessoa/pessoa_controller.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_page.dart';

class PessoaHome extends StatefulWidget {
  @override
  _PessoaHomeState createState() => _PessoaHomeState();
}

class _PessoaHomeState extends State<PessoaHome>
    with AutomaticKeepAliveClientMixin<PessoaHome> {
  PessoaController _bloc = BlocProvider.getBloc<PessoaController>();

  var tipoPessoaFisica = "PESSOAFISICA";
  var tipoPessoaJuridica = "PESSOAJURIDICA";

  @override
  void initState() {
    _bloc.getAll();
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.getAll();
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
    final urlArquivo = "http://192.168.1.3:8080/pessoas/download/";
    final urlAsset = "assets/images/upload/default.jpg";

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
            title: Text(p.nome, style: TextStyle(fontWeight: FontWeight.w600),),
            subtitle: Text(p.usuario.email),
            trailing: Text("${p.id}"),
            onLongPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return SubcategoriaPage();
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
