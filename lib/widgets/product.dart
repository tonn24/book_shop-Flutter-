import 'package:flutter/material.dart';
import 'package:bookshop/constant.dart';
import 'package:bookshop/screens/book_detail_screen.dart';


class ProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;

  ProductItem(this.id, this.imageUrl, this.title);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        header: GridTileBar(
          leading: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: whiteColor,
            ),
          ),
          backgroundColor: darkColor,
        ),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(BookDetailScreen.routeName, arguments: id);
          },
          child: Image.network(

            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: darkColor,
          leading: IconButton(
              icon: Icon(Icons.favorite),
              onPressed: (){},
            color: Theme.of(context).accentColor,
          ),
          title: Text(
              title,
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
