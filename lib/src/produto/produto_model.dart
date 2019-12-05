import 'package:ofertasbv/src/arquivo/arquivo_model.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';

class Produto {
  int id;
  String nome;
  String descricao;
  String foto;
  double valorUnitario;
  int quantidade;
  bool isFavorito;
  String dataRegistro;
  String codigoBarra;
  bool status;
  String unidade;
  SubCategoria subCategoria;
  Pessoa pessoa;
  List<Arquivo> arquivos;

  Produto(
      {this.id,
      this.nome,
      this.descricao,
      this.foto,
      this.valorUnitario,
      this.quantidade,
      this.isFavorito,
      this.dataRegistro,
      this.codigoBarra,
      this.status,
      this.unidade,
      this.subCategoria,
      this.pessoa, this.arquivos});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    descricao = json['descricao'];
    foto = json['foto'];
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

    if (json['arquivos'] != null) {
      arquivos = new List<Arquivo>();
      json['arquivos'].forEach((v) {
        arquivos.add(new Arquivo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['foto'] = this.foto;
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

    if (this.arquivos != null) {
      data['arquivos'] = this.arquivos.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
