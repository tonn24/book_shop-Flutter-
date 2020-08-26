import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String author;
  final double price;
  final String imageUrl;
  final String description;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.price,
    @required this.imageUrl,
    @required this.description,
      this.isFavorite = false});

  void _setFavoriteValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://book-shop-d9875.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
          url,
          body: json.encode({
        isFavorite
      }));
      if(response.statusCode >= 400) {
        _setFavoriteValue(oldStatus);
      }
    } catch(err) {
      _setFavoriteValue(oldStatus);
    }
  }
}