import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';
import 'driving_license.dart';

class RegistrationCertificateScreen extends StatefulWidget {
  static String id = "registration certificate screen";
  @override
  _RegistrationCertificateScreenState createState() => _RegistrationCertificateScreenState();
}

class _RegistrationCertificateScreenState extends State<RegistrationCertificateScreen> {
  // ignore: deprecated_member_use
  final firestore = Firestore.instance;
  final FirebaseStorage store = FirebaseStorage.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  File registrationImage;
  String url;
  String ownerName;
  String regNo;
  String chassisNo;
  String engineNo;
  String modelName;
  final  formKey = GlobalKey<FormState>();
  bool showSpinner = false;
  Future getImage() async{
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      registrationImage = tempImage as File;
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
      final Reference registrationImageRef  = FirebaseStorage.instance.ref().child("Registration Images");
      final uid = auth.currentUser.uid;
      final UploadTask uploadTask = registrationImageRef.child(uid.toString()+"registration.jpg").putFile(registrationImage);
      var registrationURL = await( await uploadTask.whenComplete(()=> null)).ref.getDownloadURL();
      url = registrationURL.toString();
      print("Image url: "+url);
      saveToDatabase(url);
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => DrivingLicenseScreen(),
      ));

    }
  }

  void saveToDatabase(url){
    var db_uid = auth.currentUser.uid;
    var data = {
      "registrationImage": url,
      "ownerName": ownerName,
      "registrationNo": regNo,
      "chassisNo": chassisNo,
      "engineNo": engineNo,
      "modelName": modelName,
    };
    firestore.collection("Registration Details").doc(db_uid).set(data);
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
          progressIndicator: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.deepOrange),),
          opacity: 1,
          color: Colors.white,
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
                    "1. Registration Certificate Details:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Center(child: registrationImage == null?Text("Your vehicle\'s registration card\'s image"): enableUpload()),

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
                Image.file(registrationImage,width: 256, height: 256),

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
                      regNo = value;
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
                      modelName = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Vehicle Model Name"
                    )
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      chassisNo = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Chassis Number"
                    )
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      engineNo = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Engine Number"
                    )
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
