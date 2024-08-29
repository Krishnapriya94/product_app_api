import 'package:flutter/material.dart';
import 'package:product_app_api/controller/product_details_controller.dart';

import 'package:product_app_api/controller/product_screen_controller.dart';
import 'package:product_app_api/view/get_started_screen/get_started_screen.dart';

import 'package:provider/provider.dart';

void main() {
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
