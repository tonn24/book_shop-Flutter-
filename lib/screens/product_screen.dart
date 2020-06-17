import 'package:flutter/material.dart';
import 'package:bookshop/widgets/product.dart';
import 'package:bookshop/widgets/products_grid.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text('BookShop')
    ),
      body: ProductsGrid(),
    );
  }
}

