import 'package:bookshop/providers/products.dart';
import 'package:bookshop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:bookshop/widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import 'cart_screen.dart';
import '../widgets/app_drawer.dart';
import 'package:http/http.dart';

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
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetBooks().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;Provider.of<Products>(context).fetchAndSetBooks();
    super.didChangeDependencies();
  }

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
        ),
        Consumer<Cart>(
          builder: (_, cart, ch)  => Badge(
            child: ch,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ),

      ],
    ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),
      )
      : ProductsGrid(_showOnlyFavorites),
    );
  }
}

