import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/puc_certificate.dart';
import 'package:echallan/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';

class InsurancePolicyScreen extends StatefulWidget {
  static String id = "insurance policy screen";
  @override
  _InsurancePolicyScreenState createState() => _InsurancePolicyScreenState();
}

class _InsurancePolicyScreenState extends State<InsurancePolicyScreen> {
  bool showSpinner = false;
  // ignore: deprecated_member_use
  final firestore = Firestore.instance;
  String url;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File insuranceImage;
  String ownerName;
  String regNo2;
  String policyNo;
  String _issued ;
  String _expiring;
  final  formKey = GlobalKey<FormState>();

  Future getImage() async{
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      insuranceImage = tempImage;
    });
  }

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }

  void uploadImage() async {
    if(validateAndSave()){
      setState(() {
        showSpinner = true;
      });
      final Reference insuranceImageRef  = FirebaseStorage.instance.ref().child("Insurance Policy Images");
      final uid = auth.currentUser.uid;
      final UploadTask uploadTask = insuranceImageRef.child(uid.toString()+"insurance.jpg").putFile(insuranceImage);
      var insuranceURL = await( await uploadTask.whenComplete(()=> null)).ref.getDownloadURL();
      url = insuranceURL.toString();
      print("Image url: "+url);
      saveToDatabase(url);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PUCCertificate()
      ));
    }
  }

  void saveToDatabase(url){
    var db_uid = auth.currentUser.uid;
    DatabaseReference insureRef = FirebaseDatabase.instance.reference();
    var data = {
      "insuranceImage": url,
      "ownerName": ownerName,
      "policyNo": policyNo,
      "registrationNo": regNo2,
      "issueDate": _issued,
      "expiringDate": _expiring
    };

    firestore.collection("Insurance Details").doc(db_uid).set(data);
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          opacity: 1,
          color: Colors.white,
          progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepOrange),),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
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
                  Text(
                    "3. Insurance Policy Details:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Center(child: insuranceImage == null?Text("Your Driving License\'s image"): enableUpload()),

                ],
              ),
            ),
          ),
        ),
        floatingActionButton: new FloatingActionButton(

          onPressed: getImage,
          backgroundColor: Colors.orangeAccent,
          tooltip: "Add Image",
          child: Icon(Icons.add_a_photo),
        )
    );
  }

  Widget enableUpload(){
    return Container(
        child: new Form(
            key: formKey,
            child: Column(
              children: [
                Image.file(insuranceImage,width: 256, height: 256),

                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      ownerName = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Owner\'s Name"
                    )
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      regNo2 = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Vehicle Registration Number"
                    )
                ),
                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      policyNo = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Insurance Policy Number"
                    )
                ),
                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                    textAlign: TextAlign.center,
                    decoration: kFieldDecoration.copyWith(
                      hintText: "Issuing Date",
                    ),
                    onChanged: (value){
                      _issued = value;
                    }),


                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                    textAlign: TextAlign.center,
                    decoration: kFieldDecoration.copyWith(
                      hintText: "Expiring Date",
                    ),
                    onChanged:(value){
                      _expiring = value;
                    }
                ),

                SizedBox(
                  height: 8.0,
                ),
                RoundedButton(
                    onPressed: uploadImage,
                    title: 'Next',
                    color: Colors.orangeAccent
                ),
              ],
            )
        )
    );
  }
}

