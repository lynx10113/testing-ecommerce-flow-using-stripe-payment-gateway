// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../resource/data.dart';
//
// Future<void> saveAddressList(List<Address> addresses) async {
//   final sharedPref = await SharedPreferences.getInstance();
//   final jsonList = addresses.map((address) => address.toJson());
//   final encodedList = jsonEncode(jsonList);
//   sharedPref.setString("address_list", encodedList).toString();
// }
//
// Future<List<Address>> getAddressList() async {
//   final sharedPref = await SharedPreferences.getInstance();
//   final encodedList = sharedPref.getString("address_list");
//
//   if (encodedList == null) {
//     return [];
//   } else {
//       final List<dynamic> jsonList = jsonDecode(encodedList);
//       final addressList = jsonList.map((json) => Address.fromJson(json)).toList();
//       return addressList;
//   }
// }

import 'package:flutter/material.dart';

Decoration boxDecoration = BoxDecoration(
    border: Border.all(color: Colors.amber),
    borderRadius: BorderRadius.circular(5.0),
    color: Colors.grey.shade100,
    boxShadow: [
      const BoxShadow(
          offset: Offset(10, 10),
          color: Colors.black12,
          blurRadius: 20),
      BoxShadow(
          offset: const Offset(-10, -10),
          color: Colors.white.withOpacity(0.85),
          blurRadius: 20)
    ]);

Text textView(String text, Color color) {
  return Text(
    text,
    style:
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: color),
  );
}