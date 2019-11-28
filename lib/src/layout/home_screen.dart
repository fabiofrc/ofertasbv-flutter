import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/layout/home_tabe.dart';
import 'package:ofertasbv/src/teste/catalogo_menu.dart';

import '../../drawer_list.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          drawer: DrawerList(),
          body: HomeTabe(),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            child: Icon(Icons.apps),
            hoverColor: Colors.redAccent,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CatalogoMenu(),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
