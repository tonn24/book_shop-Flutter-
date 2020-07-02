import 'package:bookshop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'product.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;


  ProductsGrid(this.showFavorites);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFavorites? productsData.favoriteBooks : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: BookItem(
          //products[i].id,
          //products[i].imageUrl,
          //products[i].title)
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
    );
  }
}
