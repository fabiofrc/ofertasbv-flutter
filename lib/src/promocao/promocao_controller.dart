import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/promocao/promocao_api_provider.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:rxdart/rxdart.dart';

class PromocaoController extends BlocBase {
  PromocaoApiProvider _promocaoApiProvider = PromocaoApiProvider();

  PromocaoController() {
    responseOut = promocao.switchMap(create);
  }

  /* ================= get promocao ================= */
  var _streamController = StreamController<List<Promocao>>.broadcast();
  Stream<List<Promocao>> get outController => _streamController.stream;

  Future<List<Promocao>> carregaPromocoes() async {
    List<Promocao> promocoes = await _promocaoApiProvider.getAll();
    _streamController.add(promocoes);
    return promocoes;
  }

  /* ================= post promocao ================= */

  // ignore: close_sinks
  var promocao = BehaviorSubject<Promocao>();

  Promocao get promocaoValue => promocao.value;
  Observable<int> responseOut;

  Sink<Promocao> get promocaoIn => promocao.sink;

  Stream<int> create(Promocao data) async* {
    try {
      var response = await _promocaoApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    promocao.close();
    super.dispose();
  }
}
