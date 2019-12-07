import 'package:flutter/material.dart';
import 'package:ofertasbv/const.dart';
import 'package:ofertasbv/src/home/home.dart';
import 'package:splashscreen/splashscreen.dart';

bool isDark = false;

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenOne(),
      theme: isDark ? Constants.blueTheme : Constants.blueTheme,
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
            Colors.blue[900],
            Colors.indigo[500],
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        seconds: 4,
        navigateAfterSeconds: HomePage(),
        title: Text(
          'OFERTASBV',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        image: Image.asset(urlLogo),
        //backgroundColor: Color(0xff622F74),
        styleTextUnderTheLoader: TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.orangeAccent,
      ),
    );
  }
}
