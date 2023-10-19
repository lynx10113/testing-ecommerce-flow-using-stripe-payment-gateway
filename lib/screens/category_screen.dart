import 'package:flutter/material.dart';
import 'package:food_order/screens/cart_screen.dart';
import '../resource/data.dart';

class CategoryItemScreen extends StatefulWidget {
  const CategoryItemScreen({super.key});

  @override
  State<CategoryItemScreen> createState() => _CategoryItemScreenState();
}

class _CategoryItemScreenState extends State<CategoryItemScreen> {
  // late List items;
  List items = data;
  List<Map<String, dynamic>> wishList = [];

  @override
  void initState() {
    super.initState();
    _wid();
  }

  void _wid() {
    setState(() {
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: Container(
                    margin: const EdgeInsets.only(
                        right: 20.0, top: 10.0, bottom: 14.0),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                    )),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Row(
                children: [
                  const Text(
                    "NIKE",
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(width: 10.0),
                  Image.asset('assets/images/nike.png',width: 60.0, height: 60.0)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "New Mens Shoes (${items.length.toString()})",
                    style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54),
                  ),
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CartScreen(wishList: wishList)));
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            size: 30.0,
                          )),
                      wishList.isNotEmpty
                          ? Positioned(
                              left: 28.0,
                              child: Container(
                                width: 18.0,
                                height: 18.0,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text(
                                  wishList.length.toString(),
                                  style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          : const Text(''),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 700.0,
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int position) {
                      return _categoryItem(position);
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget _categoryItem(int position) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        width: double.infinity,
        height: 180.0,
        child: Card(
          shadowColor: Colors.white,
          elevation: 6.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
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
                        child: Image.network(
                            items[position]['image'].toString(),
                            fit: BoxFit.fill),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[position]['name'],
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
                          int.parse(items[position]['percent']) > 1
                              ? "${items[position]['percent']} Colors"
                              : "${items[position]['percent']} Color",
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          "${items[position]['price'].toString()} \$",
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 26.0),
                Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey,
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rowText(Icons.star, "${items[position]['rating']}"),
                    _rowText(
                        Icons.access_time_filled, items[position]['duration']),
                    SizedBox(
                      width: 85.0,
                      height: 34.0,
                      child: FilledButton(
                        style: ButtonStyle(
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.green),
                            overlayColor: const MaterialStatePropertyAll(
                                Colors.greenAccent),
                            elevation: const MaterialStatePropertyAll(10.0),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0),
                            ))),
                        child: const Row(
                          children: [
                            Icon(Icons.add_shopping_cart, size: 20.0),
                            SizedBox(width: 6.0),
                            Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            wishList.add(items[position]);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget _rowText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.amber, size: 16.0),
        const SizedBox(width: 5.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        )
      ],
    );
  }
}
