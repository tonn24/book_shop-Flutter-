import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final String author;
  final int quantity;
  final double pricePerOne;

  CartItem({ @required this.id, @required this.title, @required this.author, @required this.quantity, @required this.pricePerOne});


}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String bookId, double price, String title, String author) {
    if(_items.containsKey(bookId)) {
      //change quantity
      _items.update(bookId, (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          pricePerOne: existingCartItem.pricePerOne,
          author: existingCartItem.author,
          quantity: existingCartItem.quantity+1,
      ));
    } else {
      //add to list
      _items.putIfAbsent(bookId, () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          pricePerOne: price,
          author: author,
          quantity: 1,
      ));
    }
    notifyListeners();
  }
}