import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_detalhes.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';

class ProdutoSearchDelegate extends SearchDelegate<Produto> {
  final _bloc = BlocProvider.getBloc<ProdutoController>();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
      autofocus: true,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _bloc.getAll();
    return StreamBuilder(
      stream: _bloc.outController,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("não foi possivel buscar categorias"),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<Produto> produtos = snapshot.data;

        final resultados = query.isEmpty
            ? produtos
            : produtos
                .where(
                    (p) => p.nome.toLowerCase().startsWith(query.toLowerCase()))
                .toList();

        return ListView.builder(
          itemBuilder: (context, index) {
            Produto p = resultados[index];
            return ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              title: RichText(
                text: TextSpan(
                    text: p.nome.substring(0, query.length),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                          text: p.nome.substring(query.length),
                          style: TextStyle(color: Colors.grey))
                    ]),
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
            );
          },
          itemCount: resultados.length,
        );
      },
    );
  }
}
