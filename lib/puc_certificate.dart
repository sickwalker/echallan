import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echallan/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'constants.dart';
import 'home_screen.dart';

class PUCCertificate extends StatefulWidget {
  static String id = "puc certificate screen";
  @override
  _PUCCertificateState createState() => _PUCCertificateState();
}

class _PUCCertificateState extends State<PUCCertificate> {
  bool showSpinner = false;
  // ignore: deprecated_member_use
  final firestore = Firestore.instance;
  String url;
  final FirebaseAuth auth= FirebaseAuth.instance;
  File pucImage;
  String regNo3;
  String serialNo;
  String _issuedPollution ;
  String _expiringPollution;
  final  formKey = GlobalKey<FormState>();

  Future getImage() async{
    // ignore: deprecated_member_use
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      pucImage = tempImage;
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
    setState(() {
      showSpinner = true;
    });
    if(validateAndSave()){
      final Reference pucImageRef  = FirebaseStorage.instance.ref().child("PUC Images");
      final uid = auth.currentUser.uid;
      final UploadTask uploadTask = pucImageRef.child(uid.toString()+"puc.jpg").putFile(pucImage);
      var pucURL = await( await uploadTask.whenComplete(()=> null)).ref.getDownloadURL();
      url = pucURL.toString();
      print("Image url: "+url);
      saveToDatabase(url);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomeScreen()
      ));
    }
  }

  void saveToDatabase(url){
    var db_uid = auth.currentUser.uid;
    //DatabaseReference pucRef = FirebaseDatabase.instance.reference();
    var data = {
      "pucImage": url,
      "registrationNo": regNo3,
      "serialNo": serialNo,
      "issued": _issuedPollution,
      "expiring": _expiringPollution
    };

    firestore.collection("PUC Details").doc(db_uid).set(data);
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
                    "4. PUC Certificate Details:",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  Center(child: pucImage == null?Text("Your PUC Certificate\'s image"): enableUpload()),

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
                Image.file(pucImage,width: 256, height: 256),

                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      regNo3 = value;
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
                      serialNo = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                        hintText: "PUC Serial Number"
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
                    _issuedPollution = value;
                  },),

                SizedBox(
                  height: 8.0,
                ),

                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: kFieldDecoration.copyWith(
                    hintText: "Expiring Date",
                  ),
                  onChanged: (value){
                    _expiringPollution = value;
                  },
                ),

                SizedBox(
                  height: 8.0,
                ),
                RoundedButton(
                    onPressed: uploadImage,
                    title: 'Submit',
                    color: Colors.orangeAccent
                ),
              ],
            )
        )
    );
  }
}

