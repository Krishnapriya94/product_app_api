import 'package:hive_flutter/adapters.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartModel {
  @HiveField(0)
  String title;
  @HiveField(1)
  String? desc;
  @HiveField(2)
  String price;
  @HiveField(3)
  String qty;
  @HiveField(4)
  String? image;

  CartModel(
      {this.desc,
      this.image,
      required this.price,
      required this.qty,
      required this.title});
}
