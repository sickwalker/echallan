import 'package:flutter/material.dart';

import 'home_screen.dart';

class ContactUs extends StatefulWidget {
  static String id = "contact us";
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.deepOrange,
            onPressed: (){
              Navigator.pushNamed(context,HomeScreen.id);
            },
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'e-Challan',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pacifico',
              color: Colors.deepOrange,
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  SizedBox(
                    height: 60.0,
                  ),
                  Text(
                      "Some account and system info will be sent to Google.We'll use the info you give us to address technical issues and improve our services,subject to our Privacy Policy and Terms of Service.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Exo",
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      )
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                      "If you wish to get in touch with us, please feel free to contact us :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Exo",
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.mail,color: Colors.deepOrange),
                      Text(
                          "adityasingh.aks96@gmail.com",
                          style: TextStyle(
                            fontFamily: "Exo",
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.phone,color: Colors.deepOrange,),
                      Text(
                          "+91-76350-10482",
                          style: TextStyle(
                            fontFamily: "Exo",
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )

    );
  }
}
