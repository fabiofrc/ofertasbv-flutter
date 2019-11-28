import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:ofertasbv/src/produto/produto_api_provider.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';
import 'package:rxdart/rxdart.dart';

class ProdutoController extends BlocBase{
  ProdutoApiProvider _produtoApiProvider = ProdutoApiProvider();

  ProdutoController(){
    responseOut = produto.switchMap(createProduto);
  }

  /* ================= get produto ================= */
  var _streamController = StreamController<List<Produto>>.broadcast();
  Stream<List<Produto>> get outController => _streamController.stream;

  Future<List<Produto>> getAll() async {
    List<Produto> produtos = await _produtoApiProvider.getAll();
    _streamController.add(produtos);
    return produtos;
  }

  Future<List<Produto>> getAllBySubCategoriaById(int id) async {
    List<Produto> produtos = await _produtoApiProvider.getAllBySubCategoriaById(id);
    _streamController.add(produtos);
    return produtos;
  }

  Future<List<Produto>> getAllByPromocaoById(int id) async {
    List<Produto> produtos = await _produtoApiProvider.getAllByPromocaoById(id);
    _streamController.add(produtos);
    return produtos;
  }

  /* ================= post produto ================= */

  // ignore: close_sinks
  var produto = BehaviorSubject<Produto>();

  Produto get produtoValue => produto.value;
  Observable<int> responseOut;

  Sink<Produto> get produtoIn => produto.sink;

  Stream<int> createProduto(Produto data) async* {
    try {
      var response = await _produtoApiProvider.create(data.toJson());
      yield response;
    } catch (e) {
      throw e;
    }
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
