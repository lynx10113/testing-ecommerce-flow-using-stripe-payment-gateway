import 'package:flutter/material.dart';
import 'package:food_order/screens/address_list_screen.dart';
import 'package:food_order/screens/category_screen.dart';
import 'package:food_order/screens/home_screen.dart';
import 'package:food_order/screens/payment_screen.dart';

const String homeScreen = '/home_screen';
const String categoryScreen = '/category_screen';
const String paymentScreen = '/payment_screen';
const String addressListScreen = '/address_screen';

Route<dynamic> controller(RouteSettings settings){
  switch(settings.name){
    case homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case categoryScreen:
    return MaterialPageRoute(builder: (context) => const CategoryItemScreen());
    case paymentScreen:
      return MaterialPageRoute(builder: (context) => const PaymentScreen());
    case addressListScreen:
      return MaterialPageRoute(builder: (context) => AddressListScreen(addressSelect: (){

      },));
    default:
      throw("named routes doesn't exit");
  }
}