import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';

class PessoaDetalhes extends StatefulWidget {
  Pessoa p;

  PessoaDetalhes(this.p);

  @override
  _PessoaDetalhesState createState() => _PessoaDetalhesState();
}

class _PessoaDetalhesState extends State<PessoaDetalhes> {
  final urlArquivo = "http://192.168.1.3:8080/produtos/download/";
  final urlAsset = "assets/images/upload/default.jpg";

  @override
  void initState() {
    urlArquivo;
    urlAsset;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Pessoa p = widget.p;

    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoa detalhes"),
        elevation: 0.0,
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
      body: buildContainer(p),
    );
  }

  buildContainer(Pessoa p) {
    return ListView(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: p.arquivo != null
              ? Image.network(urlArquivo + p.arquivo, fit: BoxFit.fill)
              : Image.network(urlAsset, fit: BoxFit.fill),
        ),
        Card(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(
                  "Cód. inscrição: ${p.id}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Pessoa: ${p.nome}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Tipo: ${p.tipoPessoa}",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),

                Text(
                  "Telefone Cel.: ${p.telefone}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  "Email: ${p.usuario.email}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Text(
                  "Endereço: ${p.endereco.logradouro + ", " + p.endereco.numero}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),

                RaisedButton.icon(
                  label: Text("Ir para produtos", style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.search,color: Colors.white,),
                  onPressed: (){
//                    Navigator.of(context).push(
//                      MaterialPageRoute(
//                        builder: (BuildContext context) {
//                          return ProdutoPage(p);
//                        },
//                      ),
//                    );
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
