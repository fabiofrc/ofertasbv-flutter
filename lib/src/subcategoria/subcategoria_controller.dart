import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_api_provider.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';
import 'package:rxdart/rxdart.dart';

class SubCategoriaController extends BlocBase {
  SubcategoriaApiProvider _subcategoriaApiProvider = SubcategoriaApiProvider();

  /* ================= get count ================= */
  // ignore: close_sinks
  final StreamController<int> _counter = BehaviorSubject<int>();
  Stream<int> get counter => _counter.stream;

  Stream<List<SubCategoria>> get listView async*{
    yield await _subcategoriaApiProvider.getAll();
  }

  SubCategoriaController() {
    try {
      responseOut = subCategoria.switchMap(createSubCategoria);
      listView.listen((list) => _counter.add(list.length));
    } catch (e) {
      throw e;
    }
  }

  /* ================= get metodo ================= */
  List<SubCategoria> subcategoriaCache;

  var _streamController = BehaviorSubject<List<SubCategoria>>();

  Stream<List<SubCategoria>> get outController => _streamController.stream;

  Future<List<SubCategoria>> getAll() async {
    List<SubCategoria> subcategorias = await _subcategoriaApiProvider.getAll();

    _streamController.add(subcategorias);
    return subcategorias;
  }

  Future<List<SubCategoria>> getAllByCategoriaById(int id) async {
    List<SubCategoria> subcategorias = await _subcategoriaApiProvider.getAllByCategoriaById(id);
    _streamController.add(subcategorias);
    return subcategorias;
  }

  /* ================= post categoria ================= */

  // ignore: close_sinks
  var subCategoria = BehaviorSubject<SubCategoria>();

  SubCategoria get subCategoriaValue => subCategoria.value;
  Observable<int> responseOut;

  Sink<SubCategoria> get subCategoriaIn => subCategoria.sink;

  Stream<int> createSubCategoria(SubCategoria data) async* {
    try {
      var response = await _subcategoriaApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    subCategoria.close();
    _counter.close();
    super.dispose();
  }
}
