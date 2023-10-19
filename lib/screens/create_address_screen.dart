import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/resource/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});

  @override
  State<CreateAddressScreen> createState() => _CreateAddressScreenState();
}

class _CreateAddressScreenState extends State<CreateAddressScreen> {
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _township = TextEditingController();
  final _state = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();

  final RegExp _nameRegExp = RegExp(r"[a-zA-Z\s]");
  final RegExp _addressRegExp = RegExp(r"[0-9a-zA-Z\s]");
  final RegExp _phoneRegExp = RegExp(r"[0-9]");
  final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  bool _isValidated = false;

  List<Address> addressList = <Address>[];
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferences();
    validationListener();
    super.initState();
  }

  void validationListener() {
    _name.addListener(formValidation);
    _address.addListener(formValidation);
    _township.addListener(formValidation);
    _state.addListener(formValidation);
    _phone.addListener(formValidation);
    _email.addListener(formValidation);
  }

  void formValidation() {
    setState(() {
      _isValidated = _name.text.isNotEmpty &&
          _address.text.isNotEmpty &&
          _township.text.isNotEmpty &&
          _state.text.isNotEmpty &&
          _phone.text.isNotEmpty &&
          _email.text.isNotEmpty;
    });
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Future<List<Address>?> loadData() async {
    List<String>? listString = sharedPreferences.getStringList('address_list');
    if (listString != null) {
      setState(() {
        addressList = listString
            .map((item) => Address.fromMap(json.decode(item)))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          "Create Address",
          style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white70,
      ),
      body: SingleChildScrollView(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Shipping Details",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              const SizedBox(height: 20.0),
              _textField("Full Name", _name, TextInputType.name, _nameRegExp),
              const SizedBox(height: 14.0),
              _textField("Street Address", _address,
                  TextInputType.streetAddress, _addressRegExp),
              const SizedBox(height: 14.0),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      flex: 2,
                      child: _textField("Township", _township,
                          TextInputType.streetAddress, _nameRegExp)),
                  const SizedBox(width: 10.0),
                  Expanded(
                      flex: 1,
                      child: _textField("State", _state,
                          TextInputType.streetAddress, _nameRegExp)),
                ],
              ),
              const SizedBox(height: 14.0),
              _textField(
                  "Phone No.", _phone, TextInputType.phone, _phoneRegExp),
              const SizedBox(height: 14.0),
              _textField(
                  "Email", _email, TextInputType.emailAddress, _emailRegExp),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 40.0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            _isValidated ? Colors.orange : Colors.grey),
                        overlayColor: MaterialStateProperty.all(Colors.amber),
                        elevation:
                            MaterialStateProperty.all(_isValidated ? 10 : 0),
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))))),
                    onPressed: _isValidated
                        ? () {
                            addItem(Address(
                                name: _name.text,
                                street: _address.text,
                                township: _township.text,
                                state: _state.text,
                                phoneNumber: _phone.text.startsWith("0")?_phone.text:"0${_phone.text}",
                                email: _email.text));
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text(
                      "Add Address",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

// @override
  @override
  Widget _textField(String hint, TextEditingController controller,
      TextInputType keyboard, RegExp regExp) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      shadowColor: Colors.black38,
      elevation: 10.0,
      child: TextField(
        controller: controller,
        style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
            letterSpacing: 1),
        inputFormatters: [
          FilteringTextInputFormatter.allow(regExp),
        ],
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(width: 2, color: Colors.amber),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2, color: Colors.orange)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(width: 2, color: Colors.grey)),
          hintText: hint,
          hintStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black26),
        ),
        keyboardType: keyboard,
      ),
    );
  }

  void addItem(Address address) {
    addressList.add(address);
    saveData();
  }

  void saveData() {
    List<String> list =
        addressList.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences.setStringList("address_list", list);
    loadData();
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _state.dispose();
    _township.dispose();
    _phone.dispose();
    _email.dispose();
    super.dispose();
  }
}
