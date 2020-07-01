import 'package:bookshop/providers/products.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String; // Gives the id
    final loadedBook = Provider.of<Products>(
        context,
        listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedBook.title),
      ),
    );
  }
}
