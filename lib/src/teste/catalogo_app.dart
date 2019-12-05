import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ofertasbv/src/home/home.dart';
import 'package:ofertasbv/src/teste/leitor_codigo_barra.dart';
import 'package:ofertasbv/src/teste/mapa_principal.dart';

import 'catalogo_menu.dart';

class CatalogoApp extends StatefulWidget {
  @override
  _CatalogoAppState createState() => _CatalogoAppState();
}

class _CatalogoAppState extends State<CatalogoApp> {
  int elementIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        CatalogoMenu(),
        LeitorCodigoBarra(),
        MapaPageApp(),
      ].elementAt(elementIndex),

      bottomNavigationBar: BubbleBottomBar(
        backgroundColor: Colors.grey[200],
        opacity: 0.2,
        currentIndex: elementIndex,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        elevation: 0.0,
        fabLocation: BubbleBottomBarFabLocation.end,
        hasNotch: true,
        hasInk: true,
        inkColor: Colors.transparent,
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.grey[700],
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.orangeAccent,
              ),
              title: Text("Dashboard")),
          BubbleBottomBarItem(
            backgroundColor: Colors.grey[700],
            icon: Icon(
              Icons.scanner,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.scanner,
              color: Colors.orangeAccent,
            ),
            title: Text("Scanner"),
          ),
        ],
        onTap: onBarTapItem,
      ),
    );
  }

  void onBarTapItem(int value) {
    setState(() {
      elementIndex = value;
    });
  }
}
