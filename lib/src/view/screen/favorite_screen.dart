import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/cart_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/controller/product_controller.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/product_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getFavoriteItems();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GetBuilder(
          builder: (ProductController controller) {
            return ProductGridView(
              items: controller.filteredProducts,
              likeButtonPressed: (index) => controller.isFavorite(index),
              isPriceOff: (product) => controller.isPriceOff(product),
            );
          },
        ),
      ),
    );
  }
}
