import 'package:flutter/material.dart';
import 'package:ofertasbv/src/promocao/promocao_create_page.dart';
import 'promocao_home.dart';


class PromocaoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ofertas"),
      ),

      body: PromocaoHome(),
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
