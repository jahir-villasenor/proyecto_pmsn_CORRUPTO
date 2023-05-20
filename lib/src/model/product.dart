import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_size_type.dart';

enum ProductType { all, watch, mobile, headphone, tablet, tv }

class Product {
  String name;
  int price;
  int? off;
  String about;
  bool isAvailable;
  ProductSizeType? sizes;
  int _quantity;
  List<String> images;
  bool isFavorite;
  double rating;
  ProductType type;

  int get quantity => _quantity;

  set quantity(int newQuantity) {
    if (newQuantity >= 0) _quantity = newQuantity;
  }

  Product({
    required this.name,
    required this.price,
    required this.about,
    required this.isAvailable,
    this.sizes,
    required this.off,
    required int quantity,
    required this.images,
    required this.isFavorite,
    required this.rating,
    required this.type,
  }) : _quantity = quantity;

  @override
  String toString() {
    return 'Product{name: $name, price: $price, about: $about, isAvailable: $isAvailable, off: $off, quantity: $quantity, images: $images, isFavorite: $isFavorite, rating: $rating, type: $type}';
  }
}
