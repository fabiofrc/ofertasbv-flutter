import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class MapaPageApp extends StatefulWidget {
  @override
  _MapaPageAppState createState() => _MapaPageAppState();
}

class _MapaPageAppState extends State<MapaPageApp> {
  Geolocator geolocator;
  Position position;
  Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  var formatadorNumber = NumberFormat("##0.0##", "pt_BR");

  Set<Marker> _marcadores = {};

  @override
  void initState() {
    super.initState();
    geolocator = Geolocator();
    LocationOptions locationOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    geolocator.getPositionStream(locationOptions).listen((Position position) {
      position = position;
    });
    carregarMarcadores();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha localização e lojas'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            GoogleMaps(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Container(
          height: 120.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              _buildInfoCard(
                  'Saraiva', '4000 ', 'Santa Tereza', 2.831360, -60.731694),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  'Goiana', '1509', 'Liberdade', 2.818428, -60.694286),
              SizedBox(width: 10.0),
              _buildInfoCard(
                  'Maluquinho', '818', 'Jardim Caranã', 2.848623, -60.724715),
              SizedBox(width: 10.0),
              _buildInfoCard('Hiper DB', '6069', 'Centro', 2.817403, -60.670905)
            ],
          ),
        ),
      ),
    );
  }

  void criarMapa(GoogleMapController controller) {
    completer.complete(controller);
  }

  GoogleMap GoogleMaps() {
    return GoogleMap(
      onTap: (pos) {
        print(pos);
      },
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      rotateGesturesEnabled: true,
      trafficEnabled: false,
      mapType: MapType.normal,
      onMapCreated: criarMapa,
      initialCameraPosition: posicaoCamera,
      markers: _marcadores,
    );
  }

  CameraPosition posicaoCamera =
      CameraPosition(target: LatLng(2.817, -60.690), zoom: 10);

  movimentarCamera(double latitude, double longitude) async {
    GoogleMapController googleMapController = await completer.future;
    googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 18)));
  }

  // ignore: missing_return
  Future<double> calcularDistancia(
      double latMercado, double longMercado) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    double distanciaMetros = await Geolocator().distanceBetween(
        position.latitude, position.longitude, latMercado, longMercado);
    double distanciaKilomentros = distanciaMetros / 1000;

    print(" distancia : ${formatadorNumber.format(distanciaKilomentros)}");
    // ignore: unnecessary_statements
    return distanciaKilomentros;
  }

  var selectedCard = 'WEIGHT';

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

  Future<ConfirmAction> showDialogAlert(
      BuildContext context, String loja, String local) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização'),
          content: Text(loja + " - " + local),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('ACEITO'),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  carregarMarcadores() {
    Set<Marker> marcadoresLocal = {};

    Marker marcadorSaraiva = Marker(
        markerId: MarkerId("marcador-saraiva"),
        position: LatLng(2.831360, -60.731694),
        infoWindow: InfoWindow(
          title: "Supermercado Saraiva",
          snippet: "Categoria Supermercado",
        ),
        icon:
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        onTap: () {
          print("Supermercado Saraiva clicado!!");
        }
        //rotation: 45
        );

    Marker marcadorGoianaLiberdade = Marker(
      markerId: MarkerId("marcador-goiana-liberdade"),
      position: LatLng(2.818428, -60.694286),
      infoWindow: InfoWindow(
        title: "Supermercado Goiana Liberdade",
        snippet: "Categoria Supermercado",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        print("Supermercado Goiana Liberdade clicado!!");
      },
    );

    Marker marcadorDbCentro = Marker(
      markerId: MarkerId("marcador-db-centro"),
      position: LatLng(2.817403, -60.670905),
      infoWindow: InfoWindow(
        title: "Supermercado Hiper DB centro",
        snippet: "Categoria Supermercado",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        print("Supermercado Hiper DB centro clicado!!");
      },
    );

    Marker marcadorMaluquinho = Marker(
      markerId: MarkerId("marcador-maluquinho"),
      position: LatLng(2.848623, -60.724715),
      infoWindow: InfoWindow(
        title: "Comercial Maluquinho",
        snippet: "Categoria Supermercado",
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      onTap: () {
        print("Comercial Maluquinho clicado!!");
      },
    );

    marcadoresLocal.add(marcadorSaraiva);
    marcadoresLocal.add(marcadorGoianaLiberdade);
    marcadoresLocal.add(marcadorDbCentro);
    marcadoresLocal.add(marcadorMaluquinho);

    setState(() {
      _marcadores = marcadoresLocal;
    });
  }

  Widget _buildInfoCard(
      String cardTitle, String info, String unit, double lat, double long) {
    return InkWell(
      onTap: () {
        selectCard(cardTitle);

        movimentarCamera(lat, long);
        calcularDistancia(lat, long);
        showToast(cardTitle, unit);
        //showDialogAlert(context, cardTitle, unit);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: cardTitle == selectedCard ? Color(0xFF7A9BEE) : Colors.white,
          border: Border.all(
            color: cardTitle == selectedCard
                ? Colors.transparent
                : Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
            width: 0.75,
          ),
        ),
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 15.0),
              child: Text(
                cardTitle,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 12.0,
                  color: cardTitle == selectedCard
                      ? Colors.white
                      : Colors.grey.withOpacity(0.9),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    info,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14.0,
                        color: cardTitle == selectedCard
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    unit,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12.0,
                      color: cardTitle == selectedCard
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showToast(String cardTitle, String unit) {
    Fluttertoast.showToast(
      msg: "Loja: $cardTitle - $unit",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.indigo,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

enum ConfirmAction { CANCEL, ACCEPT }
