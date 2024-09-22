import 'package:flutter/material.dart';
import 'package:product_app_api/controller/product_screen_controller.dart';
import 'package:product_app_api/utils/color_constants/color_constants.dart';
import 'package:product_app_api/view/cart_screen/cart_screen.dart';
import 'package:product_app_api/view/product_detail_screen/product_detail_screen.dart';
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
        await context.read<ProductScreenController>().getAllProducts();
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
          backgroundColor: Colors.transparent,
          title: Text(
            "Discover Products",
            style: TextStyle(
                color: ColorConstants.mainBlack,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border,
                    size: 30, color: ColorConstants.mainBlack)),
            SizedBox(
              width: 10,
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(),
                      ));
                },
                icon: Icon(Icons.shopping_cart_outlined,
                    size: 30, color: ColorConstants.mainBlack)),
            SizedBox(
              width: 20,
            )
          ],
        ),
        backgroundColor: ColorConstants.mainWhite,
        body: productProvider.isCategoryLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SearchBar(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorConstants.mainBlack),
                      leading: Icon(
                        Icons.search,
                        size: 30,
                        color: ColorConstants.mainGrey.withOpacity(.7),
                      ),
                      hintText: "Search",
                      hintStyle: WidgetStatePropertyAll(TextStyle(
                          color: ColorConstants.mainGrey.withOpacity(.7))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          productProvider.categoriesList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () async {
                                context
                                    .read<ProductScreenController>()
                                    .onCategorySelection(index);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        index == productProvider.selectedIndex
                                            ? ColorConstants.mainGrey
                                            : ColorConstants.mainBlack),
                                child: Center(
                                  child: Text(
                                    productProvider.categoriesList[index]
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: index ==
                                                productProvider.selectedIndex
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
                        child: productProvider.isProductLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 258,
                                        mainAxisSpacing: 20,
                                        crossAxisSpacing: 20,
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Container(
                                    //margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorConstants.mainBlack),
                                        color: ColorConstants.mainGrey
                                            .withOpacity(.5),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailScreen(
                                                        productId:
                                                            productProvider
                                                                .productsData[
                                                                    index]
                                                                .id!
                                                                .toString(),
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: ColorConstants
                                                            .mainBlack),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            productProvider
                                                                    .productsData[
                                                                        index]
                                                                    .image ??
                                                                "https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg"))),
                                              ),
                                            ),
                                            Positioned(
                                              top: 7,
                                              right: 7,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor: ColorConstants
                                                    .mainScreenBlue,
                                                child: IconButton(
                                                    onPressed: () {
                                                      context
                                                          .read<
                                                              ProductScreenController>()
                                                          .favoriteSelection(
                                                              index: index);
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      size: 25,
                                                      color:
                                                          // index ==
                                                          //         context
                                                          //             .watch<
                                                          //                 ProductScreenController>()
                                                          //             .selectFavorite
                                                          //     ? ColorConstants
                                                          //         .mainBlack:
                                                          ColorConstants
                                                              .mainGrey,
                                                    )),
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                maxLines: 1,
                                                productProvider
                                                        .productsData[index]
                                                        .title ??
                                                    "no data",
                                                style: TextStyle(
                                                    color: ColorConstants
                                                        .mainBlack,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${productProvider.productsData[index].price.toString()} \$",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: ColorConstants
                                                          .mainBlack),
                                                  child: Center(
                                                    child: Text(
                                                      "Add to Cart",
                                                      style: TextStyle(
                                                          color: ColorConstants
                                                              .mainWhite),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: productProvider.productsData.length,
                              ))
                  ],
                ),
              ));
  }
}
