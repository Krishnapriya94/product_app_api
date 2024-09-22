import 'package:flutter/material.dart';
import 'package:product_app_api/utils/color_constants/color_constants.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.price,
    required this.qty,
    required this.image,
  });

  final String title;
  final String desc;
  final String price;
  final String qty;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.mainGrey),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.mainBlack),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://th.bing.com/th/id/OIP.E-8vU39x4tlh4F-rx-gT6wHaEK?rs=1&pid=ImgDetMain"))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(price),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  ElevatedButton(onPressed: () {}, child: Icon(Icons.add)),
                  Text(qty),
                  ElevatedButton(onPressed: () {}, child: Icon(Icons.remove)),
                ],
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: ColorConstants.mainBlack,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                "Remove",
                style: TextStyle(color: ColorConstants.mainWhite),
              ),
            ),
          )
        ],
      ),
    );
  }
}
