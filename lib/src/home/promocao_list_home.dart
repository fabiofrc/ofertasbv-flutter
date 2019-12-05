import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ofertasbv/src/api/constant_api.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_detalhes.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';

class PromocaoListHome extends StatefulWidget {
  Pessoa p;
  PromocaoListHome({Key key, this.p}) : super(key: key);

  @override
  _PromocaoListHomeState createState() => _PromocaoListHomeState(p: this.p);
}

class _PromocaoListHomeState extends State<PromocaoListHome>
    with AutomaticKeepAliveClientMixin<PromocaoListHome> {
  final _bloc = BlocProvider.getBloc<PromocaoController>();

  Pessoa p;
  _PromocaoListHomeState({this.p});

  @override
  void initState() {
    if (p != null) {
      _bloc.getAllByPessoaById(this.p.id);
    } else {
      _bloc.getAll();
    }
    super.initState();
  }

  Future<void> onRefresh() {
    return _bloc.getAll();
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
            child: builderListPromocoes(promocoes),
          );
        },
      ),
    );
  }

  ListView builderListPromocoes(List<Promocao> promocoes) {
    final DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: promocoes.length,
      itemBuilder: (context, index) {
        Promocao p = promocoes[index];

        return GestureDetector(
          child: Card(
            margin: EdgeInsets.only(left: 5),
            elevation: 0.0,
            child: AnimatedContainer(
              duration: Duration(seconds: 4),
              width: 300,
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        ConstantApi.urlArquivoPromocao + p.foto,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(p.nome, style: TextStyle(fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
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
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
