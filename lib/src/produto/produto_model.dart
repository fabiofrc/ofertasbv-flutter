import 'package:flutter/foundation.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class Produto {
  int id;
  String nome;
  String descricao;
  String arquivo;
  double valorUnitario;
  int quantidade;
  bool isFavorito;
  String dataRegistro;
  String codigoBarra;
  bool status;
  String unidade;
  SubCategoria subCategoria;
  Pessoa pessoa;

  Produto(
      {this.id,
      this.nome,
      this.descricao,
      this.arquivo,
      this.valorUnitario,
      this.quantidade,
      this.isFavorito,
      this.dataRegistro,
      this.codigoBarra,
      this.status,
      this.unidade,
      this.subCategoria,
      this.pessoa});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    arquivo = json['arquivo'];
    valorUnitario = json['valorUnitario'];
    quantidade = json['quantidade'];
    isFavorito = json['isFavorito'];
    dataRegistro = json['dataRegistro'];
    codigoBarra = json['codigoBarra'];
    status = json['status'];
    unidade = json['unidade'];
    subCategoria = json['subCategoria'] != null
        ? new SubCategoria.fromJson(json['subCategoria'])
        : null;
    pessoa =
        json['pessoa'] != null ? new Pessoa.fromJson(json['pessoa']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['arquivo'] = this.arquivo;
    data['valorUnitario'] = this.valorUnitario;
    data['quantidade'] = this.quantidade;
    data['isFavorito'] = this.isFavorito;
    data['dataRegistro'] = this.dataRegistro;
    data['codigoBarra'] = this.codigoBarra;
    data['status'] = this.status;
    data['unidade'] = this.unidade;
    if (this.subCategoria != null) {
      data['subCategoria'] = this.subCategoria.toJson();
    }
    if (this.pessoa != null) {
      data['pessoa'] = this.pessoa.toJson();
    }
    return data;
  }
}
