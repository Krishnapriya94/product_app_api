import 'package:flutter/material.dart';
import 'package:product_app_api/controller/product_details_controller.dart';
import 'package:product_app_api/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  final String productId;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await context
            .read<ProductDetailsController>()
            .getSingleProduct(widget.productId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productDetailsProvider = context.watch<ProductDetailsController>();
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: ColorConstants.mainWhite,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.mainBlack),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            productDetailsProvider.productByIdModel?.image ??
                                ""))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              productDetailsProvider.productByIdModel?.title ?? "",
              style: TextStyle(
                  color: ColorConstants.mainBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                " ${productDetailsProvider.productByIdModel?.price.toString() ?? ""} \$",
                style: TextStyle(
                    color: ColorConstants.mainBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text(
                productDetailsProvider.productByIdModel?.rating.toString() ??
                    "",
                style: TextStyle(
                    color: ColorConstants.mainBlack,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            Text(
              maxLines: 5,
              productDetailsProvider.productByIdModel?.description ?? "",
              style: TextStyle(
                  color: ColorConstants.mainBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: ColorConstants.mainBlack,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text("Add to Cart",
                    style: TextStyle(
                        color: ColorConstants.mainWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
