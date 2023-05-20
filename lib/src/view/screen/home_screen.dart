import 'package:proyecto_pmsn_villasenor_y_vazquez/src/firebase/firestore_products.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_category.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/widget/page_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_data.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/cart_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/profile_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/favorite_screen.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/view/screen/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static List<Widget> screens = [
    const ProductListScreen(),
    const FavoriteScreen(),
    const CartScreen(),
    ProfileScreen()
  ];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newIndex = 0;
  FirestoreProducts firestoreProducts = FirestoreProducts();

  void fetchData() async {
    List<ProductCategory> categories = await firestoreProducts.getCategories();
    List<Product> products = await firestoreProducts.getProducts();

    print('Categorías recibidas: $categories');
    print('Productos recibidos: $products');
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return PageWrapper(
      child: Scaffold(
        bottomNavigationBar: BottomNavyBar(
          itemCornerRadius: 10,
          selectedIndex: newIndex,
          items: AppData.bottomNavyBarItems
              .map(
                (item) => BottomNavyBarItem(
                  icon: item.icon,
                  title: Text(item.title),
                  activeColor: item.activeColor,
                  inactiveColor: item.inActiveColor,
                ),
              )
              .toList(),
          onItemSelected: (currentIndex) {
            newIndex = currentIndex;
            setState(() {});
          },
        ),
        body: PageTransitionSwitcher(
          duration: const Duration(seconds: 1),
          transitionBuilder: (
            Widget child,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
          child: HomeScreen.screens[newIndex],
        ),
      ),
    );
  }
}
