import 'package:echallan/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = "registration screen";
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name;
  String email;
  String phone;
  String aadhar;
  String password;

  bool _isSuccess;
  String _userEmail;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepOrange),),
            opacity: 1,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SafeArea(
                        child:
                        Hero(
                          tag: 'logo',
                          child: Container(
                            height: 200.0,
                            child: Image.asset('images/logo.jpg'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),

                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            name = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Your Name"
                          )
                      ),


                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            email = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Your E-mail")
                      ),


                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Your Mobile Number")
                      ),


                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            aadhar = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Enter your Aadhar Number")
                      ),


                      SizedBox(
                        height: 10.0,
                      ),

                      TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password =value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Password")
                      ),

                      SizedBox(
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.deepOrangeAccent.shade400,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: (){
                              _registerAccount();
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
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

  void _registerAccount() async {
    setState(() {
      showSpinner = true;
    });
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )).user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();

      }
      await user.updateProfile(displayName: name);
      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => VerifyScreen()));
      setState(() {
        showSpinner = false;
      });
    } else {
      _isSuccess = false;
    }
  }
}
