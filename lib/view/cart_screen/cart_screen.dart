import 'package:flutter/material.dart';
import 'package:product_app_api/utils/color_constants/color_constants.dart';
import 'package:product_app_api/view/cart_screen/widgets/cart_item_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => CartItemWidget(
                      title: '',
                      desc: '',
                      price: '',
                      qty: '',
                      image: '',
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: 10),
          )
        ]),
      ),
    );
  }
}
