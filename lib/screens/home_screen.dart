import 'package:flutter/material.dart';
import 'package:food_order/screens/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final categories = [
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b01e8d15-ffab-4f2b-af64-45031aa5432c/air-force-1-07-premium-mens-shoes-FLRvC9.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/d4abdad5-4e03-4e34-a790-cb2bbd06e4c2/air-max-90-gore-tex-mens-shoes-cZwz8t.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0c1b09d2-96f6-4c23-a92e-d6745ff5920f/lebron-xxi-akoya-basketball-shoes-lnQSsH.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/hk7hv22ezuxx0qvadlt9/air-jordan-legacy-312-low-mens-shoes-B931hr.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/c7cee966-efba-4fc4-99ce-ab2ccacf9f81/infinityrn-4-gore-tex-mens-waterproof-road-running-shoes-nPh2bZ.png',
  ];

  final hotDeals = [
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b01e8d15-ffab-4f2b-af64-45031aa5432c/air-force-1-07-premium-mens-shoes-FLRvC9.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/d4abdad5-4e03-4e34-a790-cb2bbd06e4c2/air-max-90-gore-tex-mens-shoes-cZwz8t.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/0c1b09d2-96f6-4c23-a92e-d6745ff5920f/lebron-xxi-akoya-basketball-shoes-lnQSsH.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/u_126ab356-44d8-4a06-89b4-fcdcc8df0245,c_scale,fl_relative,w_1.0,h_1.0,fl_layer_apply/hk7hv22ezuxx0qvadlt9/air-jordan-legacy-312-low-mens-shoes-B931hr.png',
    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/c7cee966-efba-4fc4-99ce-ab2ccacf9f81/infinityrn-4-gore-tex-mens-waterproof-road-running-shoes-nPh2bZ.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white38,
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.0),
                          bottomRight: Radius.circular(16.0)),
                    ),
                  ),
                  Positioned.fill(
                      bottom: -50.0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                wordSpacing: 0.5,
                                color: Colors.white70),
                            keyboardType: TextInputType.text,
                            maxLines: 1,
                            maxLength: 30,
                            decoration: InputDecoration(
                                hintText: "What are you looking for?",
                                hintStyle: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white70,
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  size: 30.0,
                                  weight: 10.0,
                                ),
                                filled: true,
                                fillColor: Colors.black54,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                )),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "NIKE",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        Image.asset('assets/images/nike.png',width: 60.0, height: 60.0),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 50.0, right: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    GestureDetector(
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 80.0,
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(child: _categoryCard(position), onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return const CategoryItemScreen();
                        }));
                      },);
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Hot Deals",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    GestureDetector(
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 140.0,
                  child: ListView.builder(
                    itemCount: hotDeals.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: _dealCard(position),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const CategoryItemScreen();
                          }));
                        },
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Popular Foods",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    GestureDetector(
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 110.0,
                  child: ListView.builder(
                    itemCount: hotDeals.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        child: _popularCard(position),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const CategoryItemScreen();
                          }));
                        },
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget _categoryCard(int position) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SizedBox(
          height: 80.0,
          width: 80.0,
          child: ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.network(categories[position], fit: BoxFit.fill,)),
        ),
      );

  @override
  Widget _dealCard(int position) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 140.0,
          width: 220.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(hotDeals[position], fit: BoxFit.cover)),
        ),
      );

  @override
  Widget _popularCard(int position) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 110.0,
          width: 100.0,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(hotDeals[position], fit: BoxFit.cover)),
        ),
      );
}
