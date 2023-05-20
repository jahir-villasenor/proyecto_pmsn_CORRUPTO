import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/core/app_data.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/firebase/firestore_products.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/numerical.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_category.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_size_type.dart';

class ProductController extends GetxController {
  RxList<Product> allProducts = <Product>[].obs;
  RxList<Product> filteredProducts = <Product>[].obs;
  RxList<Product> cartProducts = <Product>[].obs;
  RxList<ProductCategory> categories = AppData.categories.obs;
  RxInt totalPrice = 0.obs;

  final firestoreProducts = FirestoreProducts();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProductsAndCategories();
  }

  Future<void> fetchProductsAndCategories() async {
    try {
      /*List<ProductCategory> fetchedCategories =
          await firestoreProducts.getCategories();
      categories.assignAll(fetchedCategories);*/

      List<Product> fetchedProducts = await firestoreProducts.getProducts();
      allProducts.assignAll(fetchedProducts);
      filteredProducts.assignAll(fetchedProducts);

      update();
    } catch (error) {
      print('Error al obtener los productos y categorias: $error');
    }
  }

  void filterItemsByCategory(int index) {
    for (ProductCategory element in categories) {
      element.isSelected = false;
    }
    categories[index].isSelected = true;

    if (categories[index].type == ProductType.all) {
      filteredProducts.assignAll(allProducts);
    } else {
      filteredProducts.assignAll(allProducts.where((item) {
        return item.type == categories[index].type;
      }).toList());
    }
    update();
  }

  void isFavorite(int index) {
    final product = filteredProducts[index];
    final productName = product.name;
    final newIsFavoriteValue = !product.isFavorite;

    firestoreProducts.updateProduct(productName, newIsFavoriteValue).then((_) {
      product.isFavorite = newIsFavoriteValue;
      update();
    });

    product.isFavorite = newIsFavoriteValue;
    update();
  }

  void addToCart(Product product) {
    product.quantity++;
    cartProducts.add(product);
    cartProducts.assignAll(cartProducts);
    calculateTotalPrice();
  }

  void increaseItemQuantity(Product product) {
    product.quantity++;
    calculateTotalPrice();
    update();
  }

  void decreaseItemQuantity(Product product) {
    product.quantity--;
    calculateTotalPrice();
    update();
  }

  bool isPriceOff(Product product) => product.off != null;

  bool get isEmptyCart => cartProducts.isEmpty;

  bool isNominal(Product product) => product.sizes?.numerical != null;

  void calculateTotalPrice() {
    totalPrice.value = 0;
    for (var element in cartProducts) {
      if (isPriceOff(element)) {
        totalPrice.value += element.quantity * element.off!;
      } else {
        totalPrice.value += element.quantity * element.price;
      }
    }
  }

  getFavoriteItems() {
    filteredProducts.assignAll(
      allProducts.where((item) => item.isFavorite),
    );
  }

  getCartItems() {
    cartProducts.assignAll(
      allProducts.where((item) => item.quantity > 0),
    );
  }

  getAllItems() {
    filteredProducts.assignAll(allProducts);
  }

  List<Numerical> sizeType(Product product) {
    ProductSizeType? productSize = product.sizes;
    List<Numerical> numericalList = [];

    if (productSize?.numerical != null) {
      for (var element in productSize!.numerical!) {
        numericalList.add(Numerical(element.numerical, element.isSelected));
      }
    }

    if (productSize?.categorical != null) {
      for (var element in productSize!.categorical!) {
        numericalList.add(
          Numerical(
            element.categorical.name,
            element.isSelected,
          ),
        );
      }
    }

    return numericalList;
  }

  void switchBetweenProductSizes(Product product, int index) {
    sizeType(product).forEach((element) {
      element.isSelected = false;
    });

    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        element.isSelected = false;
      }

      product.sizes?.categorical![index].isSelected = true;
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        element.isSelected = false;
      }

      product.sizes?.numerical![index].isSelected = true;
    }

    update();
  }

  String getCurrentSize(Product product) {
    String currentSize = "";
    if (product.sizes?.categorical != null) {
      for (var element in product.sizes!.categorical!) {
        if (element.isSelected) {
          currentSize = "Size: ${element.categorical.name}";
        }
      }
    }

    if (product.sizes?.numerical != null) {
      for (var element in product.sizes!.numerical!) {
        if (element.isSelected) {
          currentSize = "Size: ${element.numerical}";
        }
      }
    }
    return currentSize;
  }
}
