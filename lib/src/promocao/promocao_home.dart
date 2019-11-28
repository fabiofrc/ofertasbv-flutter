import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_detalhes.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';

class PromocaoHome extends StatefulWidget {
  @override
  _PromocaoHomeState createState() => _PromocaoHomeState();
}

class _PromocaoHomeState extends State<PromocaoHome>
    with AutomaticKeepAliveClientMixin<PromocaoHome> {
  final _bloc = BlocProvider.getBloc<PromocaoController>();

  @override
  void initState() {
    _bloc.carregaPromocoes();
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.carregaPromocoes();
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
    final urlArquivo = "http://192.168.1.3:8080/promocoes/download/";
    final urlAsset = "assets/images/upload/default.jpg";

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
              style: TextStyle(color: Colors.pink[700], fontSize: 18),
            ),
            onLongPress: () {
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
