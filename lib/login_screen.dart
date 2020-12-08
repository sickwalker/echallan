import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool showSpinner = false;

  final _auth =  FirebaseAuth.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
              child: ModalProgressHUD(
                inAsyncCall: showSpinner,
                color: Colors.white,
                opacity: 1,
                progressIndicator: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.deepOrangeAccent.shade400),
                ),
                child: Padding(
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
                        height: 48.0,
                      ),
                      TextField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Enter your Email")
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Enter your Password")
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.orangeAccent.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async{
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user = await _auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()
                                    ));
                                setState(() {
                                  showSpinner = false;
                                });
                              }

                              catch(e) {
                                Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder: (context) => LoginScreen()
                                ));
                              }
                            },

                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            )
        )
    );
  }
}