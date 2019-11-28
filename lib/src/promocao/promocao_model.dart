import 'package:ofertasbv/src/produto/produto_model.dart';

class Promocao {
  int id;
  String nome;
  String descricao;
  String arquivo;
  double desconto;
  String dataRegistro;
  String dataInicio;
  String dataFinal;
  List<Produto> produtos;

  Promocao(
      {this.id,
        this.nome,
        this.descricao,
        this.arquivo,
        this.desconto,
        this.dataRegistro,
        this.dataInicio,
        this.dataFinal,
        this.produtos});

  Promocao.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    arquivo = json['arquivo'];
    desconto = json['desconto'];
    dataRegistro = json['dataRegistro'];
    dataInicio = json['dataInicio'];
    dataFinal = json['dataFinal'];
    if (json['produtos'] != null) {
      produtos = new List<Produto>();
      json['produtos'].forEach((v) {
        produtos.add(new Produto.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['arquivo'] = this.arquivo;
    data['desconto'] = this.desconto;
    data['dataRegistro'] = this.dataRegistro;
    data['dataInicio'] = this.dataInicio;
    data['dataFinal'] = this.dataFinal;
    if (this.produtos != null) {
      data['produtos'] = this.produtos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}