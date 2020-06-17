import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  //final String product;
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://img.yakaboo.ua/media/catalog/product/cache/1/image/398x565/234c7c011ba026e66d29567e1be1d1f7/1/0/1024045308.jpg',
    ),
    Product(
      id: 'p1',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/71FX96Ae-PL.jpg',
    ),
    Product(
      id: 'p1',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1562884180l/42940498._SY475_.jpg',
    ),
    Product(
      id: 'p1',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/718K91oepAL.jpg',
    )
  ];

  List<Product> get items {
    return [..._items];
  }

  void addProduct() {
    //_items.add(product);
    notifyListeners();
  }
}