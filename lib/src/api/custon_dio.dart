import 'package:dio/dio.dart';
import 'package:ofertasbv/src/api/interceptions.dart';

class CustonDio {
  Dio client = Dio();

  CustonDio() {
    String urlCategoriaList = "http://192.168.1.3:8080";
    client.options.baseUrl = urlCategoriaList;

    client.interceptors.add(CustonInterceptions());
    client.options.connectTimeout = 5000;
  }
}
