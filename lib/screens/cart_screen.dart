import 'package:flutter/services.dart';
import 'package:food_order/utils/extension.dart';
import 'package:food_order/utils/item_count_provider.dart';
import 'package:provider/provider.dart';
import 'payment_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.wishList = const []});

  final List<Map<String, dynamic>> wishList;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _discountController = TextEditingController();
  late List<Map<String, dynamic>> _items = [];
  bool _hasData = false;
  String _discountCode = "";

  // FocusNode _node = FocusNode();

  @override
  void initState() {
    _items = widget.wishList;
    setState(() {
      if (_items.isNotEmpty) _hasData = true;
    });
    // _node.addListener(() {
    //   if(!_node.hasFocus) _formatForm();
    // });
    super.initState();
  }

  // void _formatForm(){
  //     _discountController.text = _discountController.text.replaceAll(" ", "");
  // }

  double _getTotalAmount() {
    double total = 0.0;
    for (var item in _items) {
      total += item['quantity'] * double.parse(item['price']);
    }
    return total;
  }

  double _getDiscount() {
    double discount = (_getTotalAmount() / 100.0) *
        (_discountCode.isNotEmpty && _discountCode.length == 6 ? 10 : 0);
    return discount;
  }

  double getTotal() {
    return _getTotalAmount() - _getDiscount();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final countProvider =
        Provider.of<ItemCountProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back,
            size: 26.0,
            color: Colors.black87,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _items.isEmpty
          ? _noDataBackground()
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Positioned.fill(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _items.length,
                        itemBuilder: (BuildContext context, int position) {
                          return _wishedItem(position, countProvider);
                        },
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                      ),
                    ),
                    _discountCard(size), // Discount Card
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.3,
                        decoration: boxDecoration,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textView("Sub-Total", Colors.black87),
                                  textView("\$ ${_getTotalAmount().toString()}",
                                      Colors.green),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textView(
                                      _discountCode.isNotEmpty &&
                                              _discountCode.length == 6
                                          ? "Discount (10%)"
                                          : "Discount",
                                      Colors.black87),
                                  textView("\$ ${_getDiscount().toString()}",
                                      Colors.green),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              Container(
                                width: double.infinity,
                                height: 2.0,
                                color: Colors.black12,
                              ),
                              const SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textView("Total", Colors.black87),
                                  textView("\$ ${getTotal().toString()}",
                                      Colors.green),
                                ],
                              ),
                              const SizedBox(height: 40.0),
                              SizedBox(
                                width: 300.0,
                                height: 40.0,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(
                                        getTotal() == 0.0 ? 0.0 : 8.0),
                                    backgroundColor: MaterialStateProperty.all(
                                        getTotal() == 0.0
                                            ? Colors.black26
                                            : Colors.orangeAccent),
                                    overlayColor:
                                        MaterialStateProperty.all(Colors.amber),
                                  ),
                                  onPressed: getTotal() != 0.0
                                      ? () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PaymentScreen(
                                                          amount: getTotal())));
                                        }
                                      : null,
                                  child: const Text(
                                    "Proceed to Checkout",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _wishedItem(int position, ItemCountProvider provider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: double.infinity,
        height: 180.0,
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 70.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(_items[position]['image'].toString(),
                          fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _items[position]['name'],
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..shader = const LinearGradient(colors: [
                                Colors.red,
                                Colors.deepOrange,
                                Colors.purple,
                                Colors.indigo,
                                Colors.green
                              ]).createShader(const Rect.fromLTWH(
                                  150.0, 100.0, 200.0, 100.0))),
                        ),
                      const SizedBox(height: 8.0),
                      Text(
                        int.parse(_items[position]['percent'])>1?"${_items[position]['percent']} Colors":"${_items[position]['percent']} Color",
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        "${_items[position]['price'].toString()} \$",
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                height: 2,
                color: Colors.grey,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _items.removeAt(position);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        size: 26.0,
                        color: Colors.black45,
                      )),
                  // _rowText(Icons.star, "${items[position]['rating']}"),
                  _countController(position),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _discountCard(Size size) {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Do you have any coupon code?",
              style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            ),
            _discountController.text.isEmpty
                ? TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.grey),
                    ),
                    onPressed: () {
                      setState(() {
                        _discountDialog(context, size);
                      });
                    },
                    child: const Text(
                      "add code",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                          decoration: TextDecoration.underline),
                    ),
                  )
                : Row(
                    children: [
                      Text(
                        _discountCode,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                      const SizedBox(width: 6.0),
                      InkWell(
                          onTap: () {
                            setState(() {
                              _discountController.text = "";
                              _discountCode = "";
                            });
                          },
                          child: const Icon(Icons.cancel, size: 24.0)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _countController(int position) {
    return Container(
      width: 110.0,
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: Colors.amber)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: const Icon(
              Icons.remove,
              size: 26.0,
              color: Colors.amber,
            ),
            onTap: () {
              setState(() {
                if (_items[position]['quantity'] > 1) {
                  _items[position]['quantity']--;
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(_items[position]['quantity'].toString(),
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54)),
          ),
          GestureDetector(
            child: const Icon(
              Icons.add,
              size: 26.0,
              color: Colors.amber,
            ),
            onTap: () {
              setState(() {
                if (_items[position]['quantity'] <= 9) {
                  _items[position]['quantity']++;
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Future _discountDialog(BuildContext context, Size size) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: AlertDialog(
              title: const Align(
                alignment: Alignment.center,
                child: Text(
                  "🎟️Pls Submit Coupon Code!",
                ),
              ),
              titleTextStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
              content: SizedBox(
                width: double.infinity,
                height: size.height * 0.127,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: SizedBox(
                        width: 120.0,
                        height: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, top: 0.0, right: 6.0, bottom: 20.0),
                          child: TextField(
                            autofocus: true,
                            controller: _discountController,
                            maxLines: 1,
                            inputFormatters: [
                              // FilteringTextInputFormatter.deny(RegExp(r'\s')),
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9a-zA-Z]")),
                              LengthLimitingTextInputFormatter(6),
                            ],
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: const BorderSide(
                                    width: 2, color: Colors.amber),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.orange)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      width: 2, color: Colors.orange)),
                              hintStyle: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _discountCode = _discountController.text;
                          });
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.amber),
                            overlayColor:
                                MaterialStateProperty.all(Colors.amber),
                            elevation: MaterialStateProperty.all(4.0),
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(4.0))))),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _noDataBackground() {
    return const Center(
      child: Text(
        "No Item Found!",
        style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          color: Colors.black45,
        ),
      ),
    );
  }
}
