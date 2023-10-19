import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/screens/address_list_screen.dart';
import 'package:food_order/screens/payment_approve_screen.dart';
import 'package:food_order/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resource/data.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, this.amount});

  final double? amount;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _holder = TextEditingController();
  final _card = TextEditingController();
  final _expiryDate = TextEditingController();
  final _cvv = TextEditingController();
  Address? _currentAddress = Address();
  late double? _totalAmount;
  final RegExp _holderRegRex = RegExp(r'[a-zA-Z\s]');
  final RegExp _cardRegRex = RegExp(r'[0-9]');
  final String? shippingAddress = "";
  bool _isValidated = false;
  late SharedPreferences sharedPreferences;
  final _paymentPath = [
    'assets/images/master.png',
    'assets/images/visa.png',
    'assets/images/gpay.png',
    'assets/images/apay.png',
  ];
  final List<bool> _isSelected = List.generate(4, (index) => false);
  int _cardItem = 0;
  final double _shippingFees = 5;

  @override
  void initState() {
    _cardItem = 0;
    setState(() {
      _totalAmount = widget.amount!;
    });
    _validationListener();
    // loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    // String? addressValue = sharedPreferences?.getString("shipping_address");
  }

  String? _fetchAddress() {
    if (_currentAddress != null) {
      return "${_currentAddress?.street ?? ""}, ${_currentAddress?.state ?? ""}";
    } else {
      return "Aungthapyay 2nd Street";
    }
    // String? addressValue = sharedPreferences?.getString("shipping_address");
    // return addressValue;

  }

  double? _totalCost() {
    return (_totalAmount != 0.0 ? _totalAmount : 0.0)! + _shippingFees;
  }

  void _validationListener() {
    _holder.addListener(_validForm);
    _card.addListener(_validForm);
    _expiryDate.addListener(_validForm);
    _cvv.addListener(_validForm);
  }

  void _validForm() {
    setState(() {
      _isValidated = _totalCost() != 0.0 &&
          _holder.text.isNotEmpty &&
          _card.text.isNotEmpty &&
          _expiryDate.text.isNotEmpty &&
          _cvv.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final Address? addressDetails = ModalRoute.of(context)?.settings.arguments as Address?;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Flexible(
                  child: Container(
                    width: double.infinity,
                    decoration: boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.directions_bike,
                                        size: 26.0, color: Colors.orange),
                                    const SizedBox(width: 10.0),
                                    const Text(
                                      "Shipping Address",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black87),
                                    ),
                                    const SizedBox(width: 10.0),
                                    const Icon(Icons.check,
                                        size: 26.0, color: Colors.orange),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  AddressListScreen(
                                                    addressSelect: (address) {
                                                      setState(() {
                                                        _currentAddress =
                                                            address;
                                                      });
                                                    },
                                                  )),
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white70),
                                          elevation:
                                              MaterialStateProperty.all(0.5),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.grey),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.orange)),
                                          minimumSize:
                                              MaterialStateProperty.all(
                                                  const Size(30.0, 30.0))),
                                      child: Text(
                                        _currentAddress == null
                                            ? "SELECT"
                                            : "CHANGE",
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _fetchAddress().toString(),
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 14.0),
                                    _textRow("Customer Name",
                                        _currentAddress?.name ?? ""),
                                    const SizedBox(height: 8.0),
                                    _textRow("Phone No.",
                                        _currentAddress?.phoneNumber ?? ""),
                                    const SizedBox(height: 9.0),
                                    _textRow(
                                        "Email", _currentAddress?.email ?? ""),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              _totalSummary(),
              const SizedBox(height: 30.0),
              _paymentMethod(),
              const SizedBox(height: 10.0),
              _cardItem == 0 || _cardItem == 1
                  ? _visaCardForm()
                  : const Center(
                      child: Text(
                        "nothing found!",
                        style: TextStyle(fontSize: 20.0, color: Colors.black87),
                      ),
                    ),
              _paymentConfirmBtn(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget _appBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
            size: 24.0,
          )),
      title: const Text(
        "Payment Summary",
        style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white70,
    );
  }

  @override
  Widget _paymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Method",
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ListView.builder(
                itemCount: _paymentPath.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: _paymentButtons(_paymentPath, index),
                  );
                },
                scrollDirection: Axis.horizontal),
          ),
        ),
      ],
    );
  }

  @override
  Widget _paymentButtons(List<String> path, int position) {
    return Container(
      width: 76.0,
      height: 38.0,
      margin: const EdgeInsets.only(right: 16.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = false;
            }
            _cardItem = position;
            _isSelected[position] = true;
          });
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              _isSelected[position] ? Colors.amber : Colors.white60),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Image.asset(path[position]),
        ),
      ),
    );
  }

  @override
  Widget _totalSummary() {
    return Container(
      decoration: boxDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView("Products", Colors.black87),
                textView("\$ $_totalAmount", Colors.green),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView("Shipping-Fees", Colors.black87),
                textView("\$ $_shippingFees", Colors.green),
              ],
            ),
            const SizedBox(height: 20.0),
            Container(width: double.infinity, height: 1.0, color: Colors.grey),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textView("Total", Colors.black87),
                textView("\$ ${_totalCost()}", Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget _visaCardForm() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Cardholder's name",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
            const SizedBox(height: 8.0),
            _formField(_holder, 20, TextInputType.name, "Iaan Dior",
                _holderRegRex, ""),
          ],
        ),
        const SizedBox(height: 24.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Card Number",
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45),
            ),
            const SizedBox(height: 8.0),
            _formField(
                _card,
                16,
                TextInputType.number,
                "1982-9860-8300-0202",
                _cardRegRex,
                _cardItem == 0
                    ? "assets/images/master.png"
                    : _cardItem == 1
                        ? "assets/images/visa.png"
                        : ""),
          ],
        ),
        const SizedBox(height: 24.0),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Expiry Date",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                    width: 100.0,
                    child: _formField(_expiryDate, 5, TextInputType.number,
                        "11/25", _cardRegRex, "")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CVV",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                      width: 100.0,
                      child: _formField(_cvv, 3, TextInputType.number, "000",
                          _cardRegRex, "")),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget _paymentConfirmBtn() {
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
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => PaymentApproveScreen(
                          name: _holder.text,
                          accNo: _card.text,
                          subTotal: _totalAmount.toString(),
                          address: _fetchAddress().toString(),
                          phone: _currentAddress?.phoneNumber,
                          totalAmount: _totalCost().toString(),
                        )));
          },
          child: const Text(
            "Confirm Payment",
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

  @override
  Widget _formField(TextEditingController controller, int maxLength,
      TextInputType keyboard, String hint, RegExp regExp, String suffix) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      inputFormatters: [
        FilteringTextInputFormatter.allow(regExp),
        LengthLimitingTextInputFormatter(maxLength),
      ],
      style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
          letterSpacing: 1),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(width: 2, color: Colors.amber),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2, color: Colors.orange)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 2, color: Colors.grey)),
        hintText: hint,
        hintStyle: const TextStyle(
            fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black26),
        suffixIcon: suffix.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Image.asset(suffix),
              )
            : null,
        suffixIconConstraints:
            const BoxConstraints(maxWidth: 80.0, maxHeight: 40.0),
      ),
    );
  }

  @override
  Row _textRow(String type, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          type,
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54),
        ),
        Text(
          value ?? "",
          style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
              color: Colors.black54),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _holder.dispose();
    _card.dispose();
    _expiryDate.dispose();
    _cvv.dispose();
    super.dispose();
  }
}
