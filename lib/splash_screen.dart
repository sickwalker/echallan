import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'welcome_screen.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  static String id = "splash screen";
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.jpg'),
              ),
            ),
            SizedBox(
              height: 40.0,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitDoubleBounce(color: Colors.deepOrangeAccent.shade400,
                  size: 50,)
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }
}