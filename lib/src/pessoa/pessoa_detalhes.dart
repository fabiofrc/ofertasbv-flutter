import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/pessoa/pessoa_list.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/pessoa/pessoa_page.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:ofertasbv/src/produto/produto_page.dart';
import 'package:ofertasbv/src/produto/produto_search.dart';
import 'package:ofertasbv/src/promocao/promocao_page.dart';

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
              : Image.asset(urlAsset, fit: BoxFit.fill),
        ),

        SizedBox(height: 0),


        Card(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(p.nome,
                      style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.location_city, color: Colors.indigo,),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(p.telefone,
                      style: TextStyle(fontSize: 16, color: Colors.grey[900]),
                    ),
                    SizedBox(height: 10),
                    Icon(Icons.phone_forwarded, color: Colors.indigo,),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    RaisedButton.icon(
                      label: Text(
                        "Ir para ofertas",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      color: Colors.pink[900],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PromocaoPage(p: p);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    RaisedButton.icon(
                      label: Text(
                        "Ir para mercados",
                        style: TextStyle(color: Colors.white),
                      ),
                      icon: Icon(
                        Icons.list,
                        color: Colors.white,
                      ),
                      color: Colors.blue[900],
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PessoaPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Card(
          elevation: 0.5,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Inscrição: ${p.id}",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                      p.tipoPessoa,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(p.usuario.email,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("${p.endereco.logradouro + ", " + p.endereco.numero}",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
