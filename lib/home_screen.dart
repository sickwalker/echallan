import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/payment_screen.dart';
import 'package:echallan/registration_certificate.dart';
import 'package:echallan/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'contact_us.dart';

class HomeScreen extends StatefulWidget {
  static String id = "home screen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String uid = FirebaseAuth.instance.currentUser.uid;
  final String email = FirebaseAuth.instance.currentUser.email;
  String regImage, licenseImage, pucImage, insuranceImage;
  String ownerNameReg, regNo, chassisNo, engineNo,modelName;
  String ownerNameLicense, licenseNo,dateOfBirth,licenseIssueDate;
  String ownerNameInsurance, regNoInsurance, policyNo, issueDate, expiringDate;
  String regNoPuc, serialNo, issuedPuc, expiredPuc;

  // ignore: deprecated_member_use
  final regRef = Firestore.instance.collection("Registration Details");
  // ignore: deprecated_member_use
  final licenseRef =Firestore.instance.collection("License Details");
  // ignore: deprecated_member_use
  final insuranceRef = Firestore.instance.collection("Insurance Details");
  // ignore: deprecated_member_use
  final pucRef = Firestore.instance.collection("PUC Details");

  Future getReg() async{
    final DocumentSnapshot data = await regRef.doc(uid).get();
    setState(() {
      regImage = data["registrationImage"];
      ownerNameReg = data["ownerName"].toString();
      regNo = data["registrationNo"];
      chassisNo = data["chassisNo"];
      engineNo = data["engineNo"];
      modelName = data["modelName"];
    });
    print(regImage);
    print(ownerNameReg);
    print(chassisNo);
  }


  Future getLicense() async{
    final DocumentSnapshot license = await licenseRef.doc(uid).get();
    setState(() {
      licenseImage = license["licenseImage"];
      ownerNameLicense = license["ownerName"];
      licenseNo = license["licenseNo"];
      dateOfBirth = license["dateofBirth"];
      licenseIssueDate = license["issueLicense"];
    });
  }

  Future getInsurance() async{
    final DocumentSnapshot insurance = await insuranceRef.doc(uid).get();
    setState(() {
      insuranceImage = insurance["insuranceImage"];
      ownerNameInsurance = insurance["ownerName"];
      policyNo = insurance["policyNo"];
      regNoInsurance = insurance["registrationNo"];
      issueDate = insurance["issueDate"];
      expiringDate = insurance["expiringDate"];
    });
  }

  Future getPuc() async{
    final DocumentSnapshot puc = await pucRef.doc(uid).get();
    setState(() {
      pucImage = puc["pucImage"];
      regNoPuc = puc["registrationNo"];
      serialNo = puc["serialNo"];
      issuedPuc = puc["issued"];
      expiredPuc = puc["expiring"];
    });
  }

  @override
  void initState() {


    super.initState();
    getReg();
    getLicense();
    getInsurance();
    getPuc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
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
          iconTheme: IconThemeData(color: Colors.orangeAccent,size: 5),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orangeAccent,width: 2.0),
                        borderRadius: BorderRadius.circular(13)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          "Name:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(ownerNameReg!=null?ownerNameReg:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Registration No.:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(regNo!=null?regNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "e-Mail ID:",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(email!=null?email:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Date of Birth: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(dateOfBirth!=null?dateOfBirth:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Vehicle Model: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(modelName!=null?modelName:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Chassis No.: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(chassisNo!=null?chassisNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Engine No.: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(engineNo!=null?engineNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Driving License No.: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(licenseNo!=null?licenseNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "License Issue Date: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(licenseIssueDate!=null?licenseIssueDate:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Insurance Policy No.: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(policyNo!=null?policyNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Issue Date: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(issueDate!=null?issueDate:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "Expiring Date: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(expiringDate!=null?expiringDate:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "PUC Serial No.: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(serialNo!=null?serialNo:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "PUC Issue Date: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(issuedPuc!=null?issuedPuc:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          "PUC Expiring Date: ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Exo",
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(expiredPuc!=null?expiredPuc:'***',style:TextStyle(fontSize: 16,fontStyle: FontStyle.italic,fontFamily: "Exo")),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )



                ],
              ),
            ),
          ),
        ),
        drawer: new Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Row(
                    children: [
                      Text("Hello ${ownerNameReg}",style: TextStyle(color:Colors.black,fontSize: 20,fontFamily: "Exo",fontStyle: FontStyle.italic),),
                    ],
                  ),
                  currentAccountPicture: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage("images/user.png"),
                        radius: 32,
                      ),

                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  )
              ),
              ListTile(
                  title: Row(
                    children: [
                      Icon(Icons.update,color: Colors.deepOrange),
                      SizedBox(width: 8.0),
                      Text(
                          "Update Documents",
                          style: TextStyle(
                            fontFamily: "Exo",
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                    ],
                  ),
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => RegistrationCertificateScreen()
                    ));
                  }
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.payment,color: Colors.deepOrange),
                    SizedBox(width: 8.0),
                    Text(
                        "Payments",
                        style: TextStyle(
                          fontFamily: "Exo",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        )
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => PaymentScreen()
                  ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.contact_mail,color: Colors.deepOrange),
                    SizedBox(width: 8.0),
                    Text(
                        "Contact Us",
                        style: TextStyle(
                          fontFamily: "Exo",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        )
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) => ContactUs()
                  ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(Icons.logout,color: Colors.deepOrange),
                    SizedBox(width: 8.0),
                    Text(
                        "Log Out",
                        style: TextStyle(
                          fontFamily: "Exo",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        )
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) => WelcomeScreen()
                  ));
                },
              )
            ],
          ),
        )
    );
  }
}
