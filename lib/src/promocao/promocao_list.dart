import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_detalhes.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';

class PromocaoList extends StatefulWidget {
  @override
  _PromocaoListState createState() => _PromocaoListState();
}

class _PromocaoListState extends State<PromocaoList>
    with AutomaticKeepAliveClientMixin<PromocaoList> {
  final _bloc = BlocProvider.getBloc<PromocaoController>();

  final urlArquivo = "http://192.168.1.3:8080/promocoes/download/";
  final urlAsset = "assets/images/upload/default.jpg";

  @override
  void initState() {
    _bloc.carregaPromocoes();
    urlArquivo;
    urlAsset;
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.carregaPromocoes();
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
              child: Text("não foi possivel buscar promoções"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Promocao> promocoes = snapshot.data;

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(promocoes),
          );
        },
      ),
    );
  }

  ListView builderList(List<Promocao> promocoes) {


    return ListView.builder(
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];
        return Card(
          margin: EdgeInsets.all(1),
          elevation: 0.0,
          child: ListTile(
            isThreeLine: true,
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
            subtitle: Text(p.descricao),
            trailing: Text(
              "${p.desconto} %",
              style: TextStyle(color: Colors.green[700], fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return PromocaoDetalhes(p);
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
