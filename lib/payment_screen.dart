import 'package:echallan/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'constants.dart';

class PaymentScreen extends StatefulWidget {
  static String id = "payment Screen";
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController amount = TextEditingController();
  final _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    print(response.paymentId.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response){
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    print(response.walletName);
  }

  void openCheckout() async {
    var options = {
      'key': 'Your RazorPay API Key goes here',
      'amount': double.parse(amount.text.trim())*100,
      'name': '',
      'description': 'e-Challan',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
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
                      Text(
                        "Enter the amount of the Challan",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                          controller: amount,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            amount.text = value;
                          },
                          decoration: kFieldDecoration.copyWith(
                              hintText: "Enter Amount")
                      ),
                      RoundedButton(
                        onPressed: openCheckout,
                        title: "Pay Now",
                        color: Colors.orangeAccent.shade400,
                      )
                    ]
                )
            )
        )
    );
  }
}
