import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_api_provider.dart';
import 'package:ofertasbv/src/subcategoria/subcategoria_model.dart';
import 'package:rxdart/rxdart.dart';

class SubCategoriaController extends BlocBase {
  SubcategoriaApiProvider _subcategoriaApiProvider = SubcategoriaApiProvider();

  SubCategoriaController() {
    responseOut = subCategoria.switchMap(createSubCategoria);
  }

  /* ================= get metodo ================= */
  List<SubCategoria> subcategoriaCache;

  var _streamController = StreamController<List<SubCategoria>>.broadcast();

  Stream<List<SubCategoria>> get outController => _streamController.stream;

  Future<List<SubCategoria>> carregaSubcategorias() async {
    List<SubCategoria> subcategorias = await _subcategoriaApiProvider.getAll();

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
    super.dispose();
  }
}
