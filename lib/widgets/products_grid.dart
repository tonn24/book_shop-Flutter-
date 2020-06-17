import 'package:bookshop/providers/products.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductItem(
          products[i].id,
          products[i].imageUrl,
          products[i].title),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
