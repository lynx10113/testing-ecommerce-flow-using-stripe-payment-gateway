import 'package:flutter/material.dart';
import 'package:food_order/screens/home_screen.dart';
import 'package:food_order/screens/main_screen.dart';
import 'package:food_order/utils/extension.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  final String recipient;
  final String subTotal;
  final String shippingFees;
  final String total;
  final bool transState;

  const PaymentSuccessfulScreen(
      {super.key,
      required this.recipient,
      required this.subTotal,
      required this.shippingFees,
      required this.total,
      required this.transState});

  @override
  State<PaymentSuccessfulScreen> createState() =>
      _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 60.0, right: 20.0, bottom: 20.0),
              child: Column(
                children: [
                  Icon(widget.transState ? Icons.check_circle : Icons.info,
                      size: 90.0,
                      color: widget.transState ? Colors.green : Colors.red),
                  const SizedBox(height: 20.0),
                  Text(
                    widget.transState ? "Payment Success!" : "Payment Failed!",
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 14.0),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      widget.transState
                          ? "Your Payment was successful, thanks for shopping with us!"
                          : "Oops! Something went terribly wrong! We can't process your payment now.",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 210.0,
                    margin: const EdgeInsets.symmetric(vertical: 40.0),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5.0),
                    //   color: Colors.grey.shade100,
                    //   boxShadow: [
                    //     BoxShadow(
                    //         offset: const Offset(10, 10),
                    //         color: Colors.black12.withOpacity(0.1),
                    //         blurRadius: 20),
                    //     BoxShadow(
                    //         offset: const Offset(-3, -3),
                    //         color: Colors.black12.withOpacity(0.1),
                    //         blurRadius: 20)
                    //   ],
                    // ),
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      child: Column(
                        children: [
                          _constantRowText("Recipient Name", widget.recipient,
                              Colors.black54, Colors.orange),
                          _constantRowText("Sub-Total", "\$${widget.subTotal}",
                              Colors.black54, Colors.green),
                          _constantRowText(
                              "Shipping-Fees",
                              "\$${widget.shippingFees}",
                              Colors.black54,
                              Colors.green),
                          Container(
                            width: double.infinity,
                            height: 1.5,
                            color: Colors.black12,
                          ),
                          const SizedBox(height: 18.0),
                          _constantRowText(
                              "Total Cost",
                              "\$${widget.total}${widget.transState == true ? "(PAID)" : "(FAILED)"}",
                              Colors.black54,
                              widget.transState ? Colors.green : Colors.red),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: _processBtn(),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _constantRowText(
      String type, String value, Color color, Color color1) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(type,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: color,
              )),
          Text(value,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: color1,
              )),
        ],
      ),
    );
  }

  Widget _processBtn() {
    return SizedBox(
      width: double.infinity,
      height: 44.0,
      child: ElevatedButton(
          onPressed: widget.transState
              ? () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext) => const MainScreen()), (route) => false);
                }
              : () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext) => const MainScreen()), (route) => false);
                },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.orange),
              overlayColor: MaterialStateProperty.all(Colors.amber),
              elevation: MaterialStateProperty.all(4.0),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))))),
          child: Text(
            widget.transState ? "Back To Home" : "Retry",
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          )),
    );
  }
}
