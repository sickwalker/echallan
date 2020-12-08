import 'package:echallan/payment_screen.dart';
import 'package:echallan/puc_certificate.dart';
import 'package:echallan/registration_certificate.dart';
import 'package:echallan/registration_screen.dart';
import 'package:echallan/splash_screen.dart';
import 'package:echallan/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'contact_us.dart';
import 'driving_license.dart';
import 'home_screen.dart';
import 'insurance_screen.dart';
import 'login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "splash screen",
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        RegistrationScreen.id : (context) => RegistrationScreen(),
        PaymentScreen.id : (context) => PaymentScreen(),
        RegistrationCertificateScreen.id : (context) => RegistrationCertificateScreen(),
        DrivingLicenseScreen.id: (context) => DrivingLicenseScreen(),
        InsurancePolicyScreen.id: (context) => InsurancePolicyScreen(),
        PUCCertificate.id: (context) => PUCCertificate(),
        HomeScreen.id: (context) => HomeScreen(),
        ContactUs.id: (context) => ContactUs(),
      },
    );
  }
}
