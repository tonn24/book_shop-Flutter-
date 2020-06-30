import 'package:flutter/material.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String; // Gives the id

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
