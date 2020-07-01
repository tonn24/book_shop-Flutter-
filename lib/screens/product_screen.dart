import 'package:bookshop/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

enum Options {
  Favorites,
  All,
}

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<Products>(context, listen: false);
    return Scaffold(appBar: AppBar(
      title: Text('BookShop'),
      actions: <Widget>[
        PopupMenuButton(
          onSelected: (Options selectedValue) {
            setState(() {
              if(selectedValue == Options.Favorites) {
                _showOnlyFavorites = true;
              } else {
                _showOnlyFavorites = false;
              }
            });
          },
          icon: Icon(Icons.more_vert,),
          itemBuilder: (_) => [
            PopupMenuItem(child: Text('Only Favorite books'), value: Options.Favorites),
            PopupMenuItem(child: Text('Show All'), value: Options.All)
          ],
        )
      ],
    ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

