import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ofertasbv/src/api/custon_dio.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';

class ProdutoApiProvider {
  CustonDio dio = CustonDio();

  Future<List<Produto>> getAll() async {
    try {
      print("carregando produtos");
      var response = await dio.client.get("/produtos");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllBySubCategoriaById(int id) async {
    try {
      print("carregando produtos");
      var response = await dio.client.get("/produtos/subcategoria/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<List<Produto>> getAllByPromocaoById(int id) async {
    try {
      print("carregando produtos");
      var response = await dio.client.get("/produtos/promocao/$id");
      return (response.data as List).map((c) => Produto.fromJson(c)).toList();
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  static Future<Produto> getProdutoByCodBarra(String codigoBarra) async {
    try {
      CustonDio dio = CustonDio();
      print("carregando produtos by codigo de barra");
      var response = await dio.client.get("/produtos/codigobarra/$codigoBarra");
      //print(response.data);
      return Produto.fromJson(response.data);
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> create(Map<String, dynamic> data) async {
    try {
      var response = await dio.client.post("/produtos/create", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      print(e.message);
    }
    return null;
  }

  Future<int> update(Map<String, dynamic> data, int id) async {
    try {
      var response = await dio.client.patch("/produtos/$id", data: data);
      return response.statusCode;
    } on DioError catch (e) {
      throw (e.message);
    }
  }

  static Future<FormData> upload(File file, String fileName) async {
    CustonDio dio = CustonDio();

    var fileDir = file.path;

    var paramentros = {
      "filename": "upload",
      "file": await MultipartFile.fromFile(fileDir, filename: fileName)
    };

    FormData formData = FormData.fromMap(paramentros);

    var response = await dio.client.post("/produtos/upload", data: formData);
    print("RESPONSE: ${response}");
    print("fileDir: ${fileDir}");
    return formData;
  }
}
