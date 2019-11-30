import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_detalhes.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_controller.dart';

class ProdutoList extends StatefulWidget {
  @override
  _ProdutoListState createState() => _ProdutoListState();
}

class _ProdutoListState extends State<ProdutoList>
    with AutomaticKeepAliveClientMixin<ProdutoList> {
  final _bloc = BlocProvider.getBloc<ProdutoController>();
  final _blocSubCategoria = BlocProvider.getBloc<SubCategoriaController>();
  final _blocPromocao = BlocProvider.getBloc<PromocaoController>();

  final urlArquivo = "http://192.168.1.3:8080/produtos/download/";
  final urlAsset = "assets/images/upload/default.jpg";

  int idSubCategoria;
  int idPromocao;

  @override
  void initState() {
    if (idSubCategoria != null) {
      _bloc.getAllBySubCategoriaById(idSubCategoria);
    } else if (idPromocao != null) {
      _bloc.getAllByPromocaoById(idPromocao);
    } else {
      _bloc.getAll();
    }
    urlArquivo;
    urlAsset;
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
              child: Text("não foi possivel buscar produtos"),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Produto> produtos = snapshot.data;

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: builderList(produtos),
          );
        },
      ),
    );
  }

  ListView builderList(List<Produto> produtos) {


    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];
        return AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.bounceIn,
          child: Card(
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
              title: Text(
                p.nome,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(p.descricao),
              trailing: Text(
                "R\$ ${p.valorUnitario}",
                style: TextStyle(
                  color: Colors.green[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ProdutoDetalhes(p);
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
