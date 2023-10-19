import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_order/screens/address_list_screen.dart';
import 'package:food_order/screens/category_screen.dart';
import 'package:food_order/screens/home_screen.dart';
import 'package:food_order/screens/main_screen.dart';
import 'package:food_order/screens/payment_screen.dart';
import 'package:food_order/utils/constants.dart';
import 'package:food_order/utils/item_count_provider.dart';
import 'package:provider/provider.dart';
import 'utils/routes.dart' as routes;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = "pk_test_51NzDEFCc3WjSVuxNjLogkCabApe8TeCZszji1omiHCdvoIPr79fL7tN5KSIOurpAzbW4BoGNbY3qIrlMHFfFtPxn00FXjYGgV3";
  // await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => ItemCountProvider(),
      child: MaterialApp(
        home: const MainScreen(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/home_screen': (context) => HomeScreen(),
          '/category_screen': (context) => CategoryItemScreen(),
          '/payment_screen': (context) => PaymentScreen(),
          '/address_screen': (context) => AddressListScreen(addressSelect: (){}),
        },
      ),
    );
  }
}
