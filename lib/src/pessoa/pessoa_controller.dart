import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/pessoa/pesssoa_api_provider.dart';
import 'package:rxdart/rxdart.dart';

class PessoaController extends BlocBase {
  PessoaApiProvider _pessoaApiProvider = PessoaApiProvider();

  /* ================= get count ================= */
  // ignore: close_sinks
  final StreamController<int> _counter = BehaviorSubject<int>();
  Stream<int> get counter => _counter.stream;

  Stream<List<Pessoa>> get listView async*{
    yield await _pessoaApiProvider.getAll();
  }

  PessoaController() {
    try {
      responseOut = pessoa.switchMap(create);
      listView.listen((list) => _counter.add(list.length));
    } catch (e) {
      throw e;
    }
  }

  /* ================= get pessoa ================= */

  var _streamController = BehaviorSubject<List<Pessoa>>();
  Stream<List<Pessoa>> get outController => _streamController.stream;

  Future<List<Pessoa>> getAll() async {
    List<Pessoa> pessoas = await _pessoaApiProvider.getAll();
    _streamController.add(pessoas);
    return pessoas;
  }

  Future<List<Pessoa>> getAllByTipo(String tipoPessoa) async {
    List<Pessoa> pessoas = await _pessoaApiProvider.getAllByTipo(tipoPessoa);
    _streamController.add(pessoas);
    return pessoas;
  }

  /* ================= post pessoa ================= */

  // ignore: close_sinks
  var pessoa = BehaviorSubject<Pessoa>();

  Pessoa get pessoaValue => pessoa.value;
  Observable<int> responseOut;

  Sink<Pessoa> get pessoasIn => pessoa.sink;

  Stream<int> create(Pessoa data) async* {
    try {
      var response = await _pessoaApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    pessoa.close();
    _counter.close();
    super.dispose();
  }
}
