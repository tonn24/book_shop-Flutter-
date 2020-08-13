import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../providers/products.dart';
import '../models/http_exception.dart';


class Products with ChangeNotifier {
  //final String product;
  List<Product> _items = [
  ];

  var _showFavoritesOnly = false;

  List<Product> get items {
    //if(_showFavoritesOnly) {
    //  return _items.where((bookItem) => bookItem.isFavorite).toList();
    //}
    return [..._items];
  }

  List<Product> get favoriteBooks {
    return _items.where((bookItem) => bookItem.isFavorite).toList();
  }


  Product findById(String id) {
    return _items.firstWhere((book) => book.id == id);
  }

  Future<void> fetchAndSetBooks() async {
    const url = 'https://book-shop-d9875.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedBooks = [];
      data.forEach((bookId, bookData) {
        loadedBooks.add(Product(
            id: bookId,
            author: bookData['author'],
            title: bookData['title'],
            imageUrl: bookData['imageUrl'],
            description: bookData['description'],
            price: bookData['price'],
            isFavorite: bookData['isFavorite']
        ));
      });
      _items = loadedBooks;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://book-shop-d9875.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'author': product.author,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        }),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
        author: product.author,
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://book-shop-d9875.firebaseio.com/products/$id.json';
      await http.patch(url, body: json.encode({
        'title': newProduct.title,
        'author': newProduct.author,
        'imageUrl': newProduct.imageUrl,
        'price': newProduct.price,
        'description': newProduct.description
      }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) async {
    final url = 'https://book-shop-d9875.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
      if(response.statusCode >= 400) {
        _items.insert(existingProductIndex, existingProduct);
        notifyListeners();
        throw HttpException('Could not delete product!');
      }
        existingProduct = null;
  }
}