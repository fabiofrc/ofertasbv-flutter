import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/promocao/promocao_api_provider.dart';
import 'package:ofertasbv/src/promocao/promocao_model.dart';
import 'package:rxdart/rxdart.dart';

class PromocaoController extends BlocBase {
  PromocaoApiProvider _promocaoApiProvider = PromocaoApiProvider();

  /* ================= get count ================= */
  // ignore: close_sinks
  final StreamController<int> _counter = BehaviorSubject<int>();
  Stream<int> get counter => _counter.stream;

  Stream<List<Promocao>> get listView async*{
    yield await _promocaoApiProvider.getAll();
  }

  PromocaoController() {
    try {
      responseOut = promocao.switchMap(create);
      listView.listen((list) => _counter.add(list.length));
    } catch (e) {
      throw e;
    }
  }

  /* ================= get promocao ================= */
  var _streamController = BehaviorSubject<List<Promocao>>();
  Stream<List<Promocao>> get outController => _streamController.stream;

  Future<List<Promocao>> getAll() async {
    List<Promocao> promocoes = await _promocaoApiProvider.getAll();
    _streamController.add(promocoes);
    return promocoes;
  }

  Future<List<Promocao>> getAllByPessoaById(int id) async {
    List<Promocao> promocoes = await _promocaoApiProvider.getAllByPessoaById(id);
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
    //_counter.close();
    super.dispose();
  }
}
