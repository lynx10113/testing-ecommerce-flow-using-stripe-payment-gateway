import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_order/screens/create_address_screen.dart';
import 'package:food_order/screens/payment_screen.dart';
import 'package:food_order/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resource/data.dart';

class AddressListScreen extends StatefulWidget {
  Function addressSelect;
  AddressListScreen({super.key,required this.addressSelect});

  @override
  State<AddressListScreen> createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  List<Address> addressList = <Address>[];
  late Address? addressDetails;
  late SharedPreferences sharedPreferences;
  bool isClicked = false;

  @override
  void initState() {
    setState(() {
      loadSharedPreferences();
    });
    super.initState();
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
    return null; //****
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Create new Address",
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const CreateAddressScreen()));
                    },
                    icon: const Icon(Icons.add_circle, size: 30.0),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                    itemCount: addressList.length,
                    itemBuilder: (BuildContext context, int position) {
                      return addressList.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  isClicked = !isClicked;
                                });
                              },
                              child: _addressCard(position, addressList),
                            )
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    }),
              ),
            ],
          )),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
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
        "Addresses",
        style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.white70,
    );
  }

  Widget _addressCard(int position, List<Address> address) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // setState(() {
        //   addressDetails = address[position];
        // });
        widget.addressSelect(address[position]);
        String shippingAddress = "${address[position].street}, ${address[position].state}";
        sharedPreferences.setString('shipping_address', shippingAddress);
        Navigator.pop(context);
        // Navigator.popAndPushNamed(context, "/payment_screen",
        //     arguments: addressDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        width: double.infinity,
        height: size.height * 0.12,
        decoration: boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                addressList[position].name??"",
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange),
              ),
              const SizedBox(height: 10.0),
              Text(
                "${address[position].street}, ${address[position].township}, ${address[position].state}",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: isClicked ? Colors.white : Colors.black87),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    address[position].email??"",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: isClicked ? Colors.white : Colors.black87),
                  ),
                  Text(
                        addressList[position].phoneNumber??"",
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: isClicked ? Colors.white : Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
