import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:product_app_api/controller/product_details_controller.dart';

import 'package:product_app_api/controller/product_screen_controller.dart';
import 'package:product_app_api/model/cart_model/cart_model.dart';
import 'package:product_app_api/view/get_started_screen/get_started_screen.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductScreenController(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductDetailsController(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: GetStartedScreen(),
        ));
  }
}
