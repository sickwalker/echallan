import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:echallan/registration_screen.dart';
import 'package:echallan/rounded_button.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 1,milliseconds: 500),
        vsync: this
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.jpg'),
                    height: animation.value*78,
                  ),
                ),
                TyperAnimatedTextKit(
                    text: ['e-Challan'],
                    textStyle: TextStyle(
                      fontFamily: 'Pacifico',
                      color: Colors.deepOrange,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                    ),
                    isRepeatingAnimation: false,
                    textAlign: TextAlign.start,
                    alignment: AlignmentDirectional.topStart
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: "Log In",
              color: Colors.orangeAccent.shade400,
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: "Register",
              color: Colors.deepOrangeAccent.shade400,
              onPressed: (){Navigator.pushNamed(context, RegistrationScreen.id);},
            )
          ],
        ),
      ),
    );
  }
}

