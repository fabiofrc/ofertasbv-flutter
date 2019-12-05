import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/arquivo/arquivo_api_provider.dart';
import 'package:ofertasbv/src/arquivo/arquivo_model.dart';
import 'package:rxdart/rxdart.dart';


class ArquivoController extends BlocBase {
  ArquivoApiProvider _arquivoApiProvider = ArquivoApiProvider();

  /* ================= get count ================= */
  // ignore: close_sinks
  final StreamController<int> _counter = BehaviorSubject<int>();
  Stream<int> get counter => _counter.stream;

  Stream<List<Arquivo>> get listView async*{
    yield await _arquivoApiProvider.getAll();
  }

  ArquivoController() {
    try {
      responseOut = arquivo.switchMap(createArquivo);
      listView.listen((list) => _counter.add(list.length));
    } catch (e) {
      throw e;
    }
  }

  /* ================= get categoria ================= */

  var _streamController = BehaviorSubject<List<Arquivo>>();
  Stream<List<Arquivo>> get outController => _streamController.stream;


  Future<List<Arquivo>> getAll() async {
    List<Arquivo> arquivos = await _arquivoApiProvider.getAll();
    _streamController.add(arquivos);
    return arquivos;
  }


  /* ================= post categoria ================= */

  // ignore: close_sinks
  var arquivo = BehaviorSubject<Arquivo>();

  Arquivo get categoriaValue => arquivo.value;
  Observable<int> responseOut;

  Sink<Arquivo> get arquivoIn => arquivo.sink;

  Stream<int> createArquivo(Arquivo data) async* {
    try {
      var response = await _arquivoApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    arquivo.close();
    //_counter.close();
    super.dispose();
  }
}
