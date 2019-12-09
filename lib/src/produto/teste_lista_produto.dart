import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/produto/produto_controller.dart';
import 'package:ofertasbv/src/produto/produto_model.dart';

class TesteListProduto extends StatefulWidget {
  @override
  _TesteListProdutoState createState() => _TesteListProdutoState();
}

class _TesteListProdutoState extends State<TesteListProduto> {
  List<Produto> photos;
  List<int> maxPhotos = [];

  @override
  void initState() {
    super.initState();

    maxPhotos.addAll(List.generate(5000, (x) => x));
    photos = [];
  }

  bool onNotification(ScrollNotification scrollInfo, ProdutoController bloc) {
    // print(scrollInfo);
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);
    }
    return false;
  }

  Widget buildListView(context, snapshot) {
    if (!snapshot.hasData) {
      return Center(child: CircularProgressIndicator());
    }

    photos.addAll(snapshot.data);

    return ListView.builder(
      itemCount: (maxPhotos.length > photos.length)
          ? photos.length + 1
          : photos.length,
      itemBuilder: (context, index) => (index == photos.length)
          ? Container(
              margin: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : ListTile(
              title: Text(photos[index].id.toString()),
              subtitle: Text(photos[index].nome),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<ProdutoController>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagination App"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) => onNotification(notification, bloc),
        child: StreamBuilder<List<Produto>>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            return buildListView(context, snapshot);
          },
        ),
      ),
    );
  }
}
