import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_order/screens/payment_successful_screen.dart';
import 'package:food_order/utils/constants.dart';
import 'package:food_order/utils/extension.dart';
import 'package:http/http.dart' as http;

class PaymentApproveScreen extends StatefulWidget {
  final String? name;
  final String? accNo;
  final String? subTotal;
  final String? address;
  final String? phone;
  final String? totalAmount;

  const PaymentApproveScreen(
      {super.key,
      this.name,
      this.accNo,
      this.subTotal,
      this.address,
      this.phone,
      this.totalAmount});

  @override
  State<PaymentApproveScreen> createState() => _PaymentApproveScreenState();
}

class _PaymentApproveScreenState extends State<PaymentApproveScreen> {
  // bool _isLoading = false;
  Map<String, dynamic>? paymentIntent;
  final String _shippingFees = "5";
  late bool _transState;

  @override
  void initState() {
    // _isLoading = false;
    super.initState();
  }

  void navigateToSuccess() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PaymentSuccessfulScreen(
                    recipient: widget.name!,
                    subTotal: widget.subTotal!,
                    shippingFees: _shippingFees,
                    total: widget.totalAmount!,
                    transState: _transState,
                  )));
    });
  }

  Future<void> makePayment() async {
    try {
      var subValue = widget.totalAmount
          .toString()
          .substring(0, widget.totalAmount!.length - 2);
      paymentIntent = await createPayment(subValue, "USD");
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            //     customFlow: true,
            // googlePay: PaymentSheetGooglePay(merchantCountryCode: 'US'),
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
            merchantDisplayName: "Nyan Lynn Htoon",
          ))
          .then((value) => {});
      displayPaymentSheet();
    } on StripeError catch (e) {
      print(e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) {
          setState(() {
            _transState = true;
          });
          showDialog(
              context: context,
              builder: (_) {
                navigateToSuccess();
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _transState ? Icons.check_circle : Icons.info,
                        color: _transState?Colors.green:Colors.red,
                        size: 100.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        _transState?"Payment Success!":"Payment Failed!",
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                );
              });
        },
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        setState(() {
          _transState = false;
        });
        navigateToSuccess();
        Fluttertoast.showToast(
            msg: 'Error from Stripe: ${e.error.localizedMessage}');
      } else {
        Fluttertoast.showToast(msg: 'Unforeseen error: ${e}');
      }
    }
  }

  createPayment(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      throw Exception(err.toString());
    }
  }

  String calculateAmount(String value) {
    var amount = int.parse(value) * 100;
    return amount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Payment Review",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        centerTitle: true,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios,
              size: 26.0, color: Colors.black38),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              "- \$${widget.totalAmount}",
                              style: const TextStyle(
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              "Total Amount",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _columnText("Recipient", widget.name!),
                      _columnText("Account No.", widget.accNo!),
                      _columnText("Sub-Total", "\$${widget.subTotal}"),
                      _columnText("Shipping-Fees", "\$$_shippingFees"),
                      _columnText("Shipping-Address", widget.address!),
                      _columnText(
                          "Phone No.",
                          !widget.phone!.startsWith("0")
                              ? "0${widget.phone!}"
                              : widget.phone!),
                      Container(
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: _paymentApproveBtn()),
                      ),
                    ],
                  )),
            ),
            // Padding(
            //         padding: const EdgeInsets.only(top: 320.0),
            //         child: Align(
            //           alignment: Alignment.center,
            //           child: Container(
            //               width: 60.0,
            //               height: 60.0,
            //               decoration: BoxDecoration(
            //                 color: Colors.black87,
            //                 borderRadius: BorderRadius.circular(10.0),
            //               ),
            //               child: const Padding(
            //                 padding: EdgeInsets.all(12.0),
            //                 child: CircularProgressIndicator(
            //                     color: Colors.orange, strokeWidth: 4),
            //               )),
            //         ),
            //       )
          ],
        ),
      ),
    );
  }

  Widget _columnText(String type, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        width: double.infinity,
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black45),
              ),
              const SizedBox(height: 10.0),
              Text(
                value,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.3,
                    letterSpacing: 0.5),
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _paymentApproveBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
      child: Container(
        width: double.infinity,
        height: 40.0,
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(8.0),
            backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
            overlayColor: MaterialStateProperty.all(Colors.amber),
          ),
          onPressed: () async {
            // setState(() {
            //   _isLoading = false;
            // });
            await makePayment();
            // await Future.delayed(const Duration(seconds: 3), () {
            //   setState(() {
            //     _isLoading = false;
            //     Navigator.pushAndRemoveUntil(
            //         context,
            //         MaterialPageRoute(
            //             builder: (_) => PaymentSuccessfulScreen()),
            //         (route) => false);
            //   });
            // });
          },
          child: const Text(
            "Approve Payment",
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
