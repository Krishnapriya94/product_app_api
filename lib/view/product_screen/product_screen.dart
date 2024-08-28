import 'package:flutter/material.dart';
import 'package:product_app_api/controller/product_screen_controller.dart';
import 'package:product_app_api/utils/color_constants/color_constants.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        // Provider.of<ProductScreenController>(context).fetchProducts();
        //await context.read<ProductScreenController>().getAllProducts();
        await context.read<ProductScreenController>().getCategories();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductScreenController>();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstants.mainScreenBlue,
          title: Text(
            "Discover Products",
            style: TextStyle(color: ColorConstants.mainWhite),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.shopping_cart,
                    size: 30, color: ColorConstants.mainWhite)),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.search,
                    size: 30, color: ColorConstants.mainWhite))
          ],
        ),
        backgroundColor: ColorConstants.mainScreenBlue,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    productProvider.categoriesList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ProductScreenController>()
                              .changeTabColor(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: index == productProvider.selectedIndex
                                  ? ColorConstants.mainWhite
                                  : ColorConstants.mainBlack),
                          child: Center(
                            child: Text(
                              productProvider.categoriesList[index]
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                  color: index == productProvider.selectedIndex
                                      ? ColorConstants.mainBlack
                                      : ColorConstants.mainWhite),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          //margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg"))),
                                  ),
                                  Positioned(
                                    top: 7,
                                    right: 7,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor:
                                          ColorConstants.mainScreenBlue,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 25,
                                            color: ColorConstants.mainGrey,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text("data"),
                                    Text("data"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: 10 //productProvider.productsData?.length,
                      ))
            ],
          ),
        ));
  }
}
