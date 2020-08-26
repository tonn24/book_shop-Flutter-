import 'package:flutter/material.dart';
import 'package:bookshop/constant.dart';
import 'package:bookshop/screens/book_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';
import '../providers/auth.dart';


class BookItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        header: GridTileBar(
          leading: Text(
            product.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
            ),
          ),
          backgroundColor: darkColor,
        ),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(
                BookDetailScreen.routeName,
                arguments: product.id
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: darkColor,
          leading: IconButton(
              icon: Icon(product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: (){
                product.toggleFavorite(
                    authData.token,
                    authData.userId);
              },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
              textAlign: TextAlign.center,
            ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title, product.author);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Added item to cart!',
                  ),
                  duration: Duration(seconds: 3),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            color: Theme.of(context).accentColor,
          ),
        )
      ),
    );
  }
}
