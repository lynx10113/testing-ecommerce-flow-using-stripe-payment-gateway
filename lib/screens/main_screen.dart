import 'package:flutter/material.dart';
import 'package:food_order/screens/cart_screen.dart';
import 'package:food_order/screens/home_screen.dart';
import 'package:food_order/screens/map_screen.dart';
import 'package:food_order/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, this.index=0});
  final int index;
  // final List<Map<String,dynamic>> list;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int pageIndex;
  // late List<Map<String,dynamic>> wishList;
  late List<Widget> screens = [];

  @override
  void initState() {
    super.initState();
    screens = [
      const HomeScreen(),
      const MapScreen(),
      const CartScreen(),
      const ProfileScreen()
    ];
    _wid();
  }

  void _wid(){
    setState(() {
      pageIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: _bottomNav()
    );
  }

  @override
  Widget _bottomNav(){
    return Container(
      width: double.infinity,
      height: 64.0,
      decoration: const BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.amber,
              spreadRadius: 1
          ),
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                Icons.home,
                size: 30.0,
              )
                  : const Icon(
                Icons.home_outlined,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                Icons.location_on,
                size: 30.0,
              )
                  : const Icon(
                Icons.location_on_outlined,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                Icons.shopping_cart,
                size: 30.0,
              )
                  : const Icon(
                Icons.shopping_cart_outlined,
                size: 30.0,
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                Icons.person,
                size: 30.0,
              )
                  : const Icon(
                Icons.person_outline,
                size: 30.0,
              )),
        ],
      ),
    );
  }
}
