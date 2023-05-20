import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_category.dart';

class FirestoreProducts {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, int> iconMap = {
    'Icons.all_inclusive': 0xe07e,
    'Icons.tablet_mac': 0xe63f,
    'Icons.tablet': 0xe63d,
    'Icons.headphones': 0xe2ff,
    'Icons.tv': 0xe687,
  };

  Future<List<ProductCategory>> getCategories() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('categories').get();
    List<ProductCategory> categories = querySnapshot.docs.map((doc) {
      final String typeString = doc.get('type');
      final ProductType type = getProductTypeFromString(typeString);
      final String iconString = doc.get('icon');
      final int codePoint = iconMap[iconString] ?? 0xe07e;
      final IconData icon = IconData(codePoint, fontFamily: 'MaterialIcons');
      return ProductCategory(type, doc.get('isSelected'), icon);
    }).toList();

    print('Categorias obtenidas: $categories');
    return categories;
  }

  Future<List<Product>> getProducts() async {
    final QuerySnapshot querySnapshot =
        await firestore.collection('products').get();
    List<Product> products = querySnapshot.docs.map((doc) {
      final String typeString = doc.get('type');
      final ProductType type = getProductTypeFromString(typeString);
      final imagesData = doc.get('images');
      List<String> images;
      if (imagesData is String) {
        images = [imagesData];
      } else {
        images = List<String>.from(imagesData);
      }
      return Product(
          name: doc.get('name'),
          price: doc.get('price'),
          about: doc.get('about'),
          isAvailable: doc.get('isAvailable'),
          off: doc.get('off'),
          quantity: doc.get('quantity'),
          images: images,
          isFavorite: doc.get('isFavorite'),
          rating: doc.get('rating'),
          type: type);
    }).toList();

    print('Productos obtenidos: $products');
    return products;
  }

  Future<void> updateProduct(
      String productName, bool newIsFavoriteValue) async {
    try {
      final QuerySnapshot querySnapshot = await firestore
          .collection('products')
          .where('name', isEqualTo: productName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final docRef = querySnapshot.docs.first.reference;
        await docRef.update({'isFavorite': newIsFavoriteValue});
      }
    } catch (error) {
      print('Error al actualizar el producto: $error');
    }
  }
}

ProductType getProductTypeFromString(String typeString) {
  switch (typeString) {
    case 'all':
      return ProductType.all;
    case 'watch':
      return ProductType.watch;
    case 'mobile':
      return ProductType.mobile;
    case 'headphone':
      return ProductType.headphone;
    case 'tablet':
      return ProductType.tablet;
    case 'tv':
      return ProductType.tv;
    default:
      throw Exception('Unknowm ProductType: $typeString');
  }
}
