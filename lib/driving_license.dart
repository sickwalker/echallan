import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';
import 'insurance_screen.dart';

class DrivingLicenseScreen extends StatefulWidget {
  static String id = "driving license screen";
  @override
  _DrivingLicenseScreenState createState() => _DrivingLicenseScreenState();
}

class _DrivingLicenseScreenState extends State<DrivingLicenseScreen> {
  bool showSpinner = false;
  // ignore: deprecated_member_use
  final firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String url;
  File licenseImage;
  String dob;
  String issueLicense;
  String ownerName;
  String licenseNo;
  final  formKey = GlobalKey<FormState>();

  Future getImage() async{
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      licenseImage = tempImage;
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
      final Reference licenseImageRef  = FirebaseStorage.instance.ref().child("License Images");
      final uid = auth.currentUser.uid;
      final UploadTask uploadTask = licenseImageRef.child(uid.toString()+"license.jpg").putFile(licenseImage);
      var licenseURL = await( await uploadTask.whenComplete(()=> null)).ref.getDownloadURL();
      url = licenseURL.toString();
      print("Image url: "+url);
      saveToDatabase(url);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => InsurancePolicyScreen()
      ));
    }
  }

  void saveToDatabase(url){
    var db_uid = auth.currentUser.uid;
    DatabaseReference licRef = FirebaseDatabase.instance.reference();
    var data = {
      "licenseImage": url,
      "ownerName": ownerName,
      "licenseNo": licenseNo,
      "dateofBirth": dob,
      "issueLicense":issueLicense
    };

    firestore.collection("License Details").doc(db_uid).set(data);
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
          color: Colors.white,
          opacity: 1,
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
                    "2. Driving License Details:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Center(child: licenseImage == null?Text("Your Driving License\'s image"): enableUpload()),

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
                Image.file(licenseImage,width: 256, height: 256),

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
                  textAlign: TextAlign.center,
                  decoration: kFieldDecoration.copyWith(
                    hintText: "Date of Birth",
                  ),
                  onChanged:(value) {
                    dob = value;
                  },),

                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      licenseNo = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "Driving License Number"
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
                  onChanged:(value) {
                    issueLicense = value;
                  },
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

