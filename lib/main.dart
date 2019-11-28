import 'package:flutter/material.dart';
import 'package:ofertasbv/home.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          disabledBorder: InputBorder.none,
        ),
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreenOne(),
    ));

class SplashScreenOne extends StatefulWidget {
  @override
  _SplashScreenOneState createState() => new _SplashScreenOneState();
}

class _SplashScreenOneState extends State<SplashScreenOne> {
  static final urlLogo = "assets/images/categorias/ofertasbv.png";

  @override
  void initState() {
    urlLogo; // ignore: unnecessary_statements
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen(
        gradientBackground: LinearGradient(
          colors: [
            Colors.deepOrange,
            Colors.deepOrange[400],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        seconds: 4,
        navigateAfterSeconds: HomePage(),
        title: Text(
          'OFERTASBV',
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        image: Image.asset(urlLogo),
        backgroundColor: Color(0xff622F74),
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.white,
      ),
    );
  }
}
