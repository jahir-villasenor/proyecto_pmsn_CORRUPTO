import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/model/product_api.dart';
import 'package:proyecto_pmsn_villasenor_y_vazquez/src/network/api_products.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<ProductApi> _products = [];
  bool _isLoading = false;
  ApiProducts _apiProducts = ApiProducts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final List<dynamic> response = await _apiProducts.getProducts();
      final List<ProductApi> products = response
          .map((item) => ProductApi.fromJson(item as Map<String, dynamic>))
          .toList();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _products.length,
              itemBuilder: (context, index) {
                final product = _products[index];
                return ListTile(
                  leading: Image.network(product.image!),
                  title: Text(
                    product.title!,
                    style: TextStyle(color: Colors.black),
                  ),
                  subtitle: Text(
                    product.description!,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              },
            ),
    );
  }
}
