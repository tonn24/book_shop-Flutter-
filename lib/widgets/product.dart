import 'package:flutter/material.dart';
import 'package:bookshop/constant.dart';
import 'package:bookshop/screens/book_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';


class bookItem extends StatelessWidget {
  //final String id;
  //final String imageUrl;
  //final String title;

  //bookItem(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
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
                product.toggleFavorite();
              },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            product.title,
              textAlign: TextAlign.center,
            ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: (){},
            color: Theme.of(context).accentColor,
          ),
        )
      ),
    );
  }
}
