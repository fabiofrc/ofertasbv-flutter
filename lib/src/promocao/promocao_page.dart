import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/pessoa/pessoa_model.dart';
import 'package:ofertasbv/src/promocao/promocao_controller.dart';
import 'package:ofertasbv/src/promocao/promocao_create_page.dart';
import 'promocao_list.dart';


class PromocaoPage extends StatefulWidget {

  Pessoa p;
  PromocaoPage({Key key, this.p}) : super(key: key);

  @override
  _PromocaoPageState createState() => _PromocaoPageState(p: this.p);
}

class _PromocaoPageState extends State<PromocaoPage> {
  final _bloc = BlocProvider.getBloc<PromocaoController>();

  Pessoa p;
  _PromocaoPageState({this.p});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ofertas"),
        elevation: 0.0,
        actions: <Widget>[
          StreamBuilder<Object>(
            stream: _bloc.counter,
            builder: (context, data) {
              return Chip(
                label: Text(
                  (data.data ?? 0).toString(),
                  style: TextStyle(color: Colors.white70),
                ),
              );

            },
          ),
          SizedBox(width: 10,),
        ],
      ),

      body: PromocaoList(p: p),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 8,
            height: 8,
          ),
          FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PromocaoCreatePage()));
            },
          )
        ],
      ),
    );
  }
}
