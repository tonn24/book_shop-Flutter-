import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class Products with ChangeNotifier {
  //final String product;
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://img.yakaboo.ua/media/catalog/product/cache/1/image/398x565/234c7c011ba026e66d29567e1be1d1f7/1/0/1024045308.jpg',
      description: "Homo Deus is audacious, speculative and thought-provoking. And for Brand Genetics, an agency that believes that the future is human, Homo Deus is a direct challenge to our faith in human strengths, human values and human experience. ... We should be decoding the algorithms of human behaviour.",
    ),
    Product(
      id: 'p2',
      title: 'Homo Deus',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/71FX96Ae-PL.jpg',
        description: "Homo Deus is audacious, speculative and thought-provoking. And for Brand Genetics, an agency that believes that the future is human, Homo Deus is a direct challenge to our faith in human strengths, human values and human experience. ... We should be decoding the algorithms of human behaviour."
    ),
    Product(
      id: 'p3',
      title: 'Limitless Mind',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://i.gr-assets.com/images/S/compressed.photo.goodreads.com/books/1562884180l/42940498._SY475_.jpg',
        description: "Homo Deus is audacious, speculative and thought-provoking. And for Brand Genetics, an agency that believes that the future is human, Homo Deus is a direct challenge to our faith in human strengths, human values and human experience. ... We should be decoding the algorithms of human behaviour."
    ),
    Product(
      id: 'p4',
      title: 'Another Title',
      author: 'Yuval Noah Harari',
      price: 19.99,
      imageUrl: 'https://images-na.ssl-images-amazon.com/images/I/718K91oepAL.jpg',
        description: "Homo Deus is audacious, speculative and thought-provoking. And for Brand Genetics, an agency that believes that the future is human, Homo Deus is a direct challenge to our faith in human strengths, human values and human experience. ... We should be decoding the algorithms of human behaviour."
    )
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

  void addProduct() {
    //_items.add(product);
    notifyListeners();
  }

}