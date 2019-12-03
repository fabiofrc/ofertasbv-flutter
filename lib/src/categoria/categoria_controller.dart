import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/categoria/categoria_api_provider.dart';
import 'package:ofertasbv/src/categoria/categoria_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaController extends BlocBase {
  CategoriaApiProvider _categoriaApiProvider = CategoriaApiProvider();

  /* ================= get count ================= */
  // ignore: close_sinks
  final StreamController<int> _counter = StreamController<int>();
  Stream<int> get counter => _counter.stream;

  Stream<List<Categoria>> get listView async*{
    yield await _categoriaApiProvider.getAll();
  }

  CategoriaController() {
    responseOut = categoria.switchMap(createCategoria);
    listView.listen((list) => _counter.add(list.length));
  }

  /* ================= get categoria ================= */

  var _streamController = StreamController<List<Categoria>>.broadcast();
  Stream<List<Categoria>> get outController => _streamController.stream;


  Future<List<Categoria>> getAll() async {
    List<Categoria> categorias = await _categoriaApiProvider.getAll();
    _streamController.add(categorias);
    return categorias;
  }

  /* ================= dropdowButton categoria ================= */
  // ignore: close_sinks
  final _selectedCat = BehaviorSubject<Categoria>();
  Stream<List<Categoria>> get selecionaCategoria => _streamController.stream;
  Function(Categoria) get changeSelectedCategoria => _selectedCat.sink.add;



  /* ================= post categoria ================= */

  // ignore: close_sinks
  var categoria = BehaviorSubject<Categoria>();

  Categoria get categoriaValue => categoria.value;
  Observable<int> responseOut;

  Sink<Categoria> get categoriaIn => categoria.sink;

  Stream<int> createCategoria(Categoria data) async* {
    try {
      var response = await _categoriaApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    categoria.close();
    //_counter.close();
    super.dispose();
  }
}
