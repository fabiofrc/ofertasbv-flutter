import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/api/constant_api.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_detalhes.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class ProdutoGrid extends StatefulWidget {

  Promocao p;
  SubCategoria s;
  ProdutoGrid({Key key, this.p, this.s}) : super(key: key);

  @override
  _ProdutoGridState createState() => _ProdutoGridState(p: this.p, s:this.s);
}

class _ProdutoGridState extends State<ProdutoGrid> with AutomaticKeepAliveClientMixin<ProdutoGrid>{
  final _bloc = BlocProvider.getBloc<ProdutoController>();

  Promocao p;
  SubCategoria s;
  _ProdutoGridState({this.p, this.s});

  @override
  void initState() {
    if (s != null) {
      _bloc.getAllBySubCategoriaById(s.id);
    } else if (p != null) {
      _bloc.getAllByPromocaoById(p.id);
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
            child: builderGrid(produtos),
          );
        },
      ),
    );
  }

  builderGrid(List<Produto> produtos) {

    return GridView.builder(
      padding: EdgeInsets.all(4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 0.65,
      ),
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];
        return GestureDetector(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            curve: Curves.bounceIn,
            child: Card(
              elevation: 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        ConstantApi.urlArquivoProduto + p.foto,
                        fit: BoxFit.fill,

                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: <Widget>[
                          Text(p.nome, style: TextStyle(fontWeight: FontWeight.w500),),
                          Text(
                            "R\$ ${p.valorUnitario}",
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ProdutoDetalhes(p);
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
