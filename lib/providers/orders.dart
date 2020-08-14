import 'package:flutter/foundation.dart';
import './cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartBooks, double total) async {
    const url = 'https://book-shop-d9875.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timeStamp.toIso8601String(),
        'products': cartBooks.map((cartBook) => {
          'id': cartBook.id,
          'title': cartBook.title,
          'author': cartBook.author,
          'quantity': cartBook.quantity,
          'price': cartBook.pricePerOne
        }).toList()
      }),
    );
    _orders.insert(0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartBooks));
  }
  notifyListeners();
}