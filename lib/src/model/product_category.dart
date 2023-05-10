import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product.dart';
import 'package:flutter/material.dart' show IconData;

class ProductCategory {
  ProductType type;
  bool isSelected;
  IconData icon;

  ProductCategory(this.type, this.isSelected, this.icon);
}
