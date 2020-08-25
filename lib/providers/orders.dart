import 'package:flutter/foundation.dart';
import './cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/auth.dart';


class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String token;


  Orders(this.token, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async  {
    final url = 'https://book-shop-d9875.firebaseio.com/orders.json?auth=$token';
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    try {
      extractedData.forEach((id, data) {
        loadedOrders.add(OrderItem(
            id: id,
            amount: data['amount'],
            dateTime: DateTime.parse(data['dateTime']),
            products: (data['products'] as List<dynamic>)
                .map((item) => CartItem(
              id: item['id'],
              pricePerOne: item['price'],
              quantity: item['quantity'],
              title: item['title'],
              author: item['author'],
            ),
            ).toList()
        ),
        );
      });
    } catch(err) {
      print('You have no book orders');
    }
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartBooks, double total) async {
    final url = 'https://book-shop-d9875.firebaseio.com/orders.json?auth=$token';
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