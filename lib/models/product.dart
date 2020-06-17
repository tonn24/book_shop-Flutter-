import 'package:flutter/foundation.dart';

class Product  {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.price,
    @required this.imageUrl,
      this.isFavorite = false});
}