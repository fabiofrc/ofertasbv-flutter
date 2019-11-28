import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';

class ProdutoDetalhes extends StatefulWidget {
  Produto p;

  ProdutoDetalhes(this.p);

  @override
  _ProdutoDetalhesState createState() => _ProdutoDetalhesState();
}

class _ProdutoDetalhesState extends State<ProdutoDetalhes> {
  var selectedCard = 'WEIGHT';
  final _bloc = BlocProvider.getBloc<ProdutoController>();

  @override
  void initState() {
    _bloc.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //String preco = p.valorUnitario.toStringAsFixed(2);
    final urlArquivo = "http://192.168.1.3:8080/produtos/download/";

    return Scaffold(
      appBar: AppBar(
        title: Text("Produto detalhes"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProdutoSearchDelegate(),
              );
            },
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Container(
              width: double.infinity,
              height: 300,
              child: Image.network(
                urlArquivo + widget.p.arquivo,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                Text(
                  widget.p.nome,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ],
            ),
          ),
          Card(
            elevation: 0.0,
            margin: EdgeInsets.all(1),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(widget.p.descricao,
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                  subtitle:
                      Text("Cód. ${widget.p.id}", style: TextStyle(fontSize: 18)),
                  trailing: Text("R\$ ${widget.p.valorUnitario}",
                      style: TextStyle(color: Colors.green[700], fontSize: 30)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> onRefresh() {
    return _bloc.getAll();
  }

  ListView builderList(List<Produto> produtos) {
    final urlArquivo = "http://192.168.1.3:8080/produtos/download/";
    final urlAsset = "asset/images/upload/default.jpg";

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        Produto p = produtos[index];
        return ListTile(
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
          title: Text(p.nome),
          subtitle: Text(p.subCategoria.nome),
          trailing: Text(
            "R\$ ${p.valorUnitario}",
            style: TextStyle(color: Colors.red),
          ),
          onLongPress: () {
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

  Widget _buildInfoCard(String cardTitle, String info, String unit) {
    return InkWell(
      onTap: () {
        selectCard(cardTitle);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
              color: cardTitle == selectedCard
                  ? Colors.transparent
                  : Colors.grey.withOpacity(0.3),
              style: BorderStyle.solid,
              width: 0.75),
        ),
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0),
              child: Text(cardTitle,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 12.0,
                    color: cardTitle == selectedCard
                        ? Colors.white
                        : Colors.grey.withOpacity(0.7),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    info,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    unit,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0,
                      color: cardTitle == selectedCard
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }
}
