import 'package:bookshop/providers/products.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String; // Gives the id
    final loadedBook = Provider.of<Products>(
        context,
        listen: false,
    ).findById(productId);
    return Scaffold(
      //appBar: AppBar(
      //  title: Text(loadedBook.title),
      //),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedBook.price.toString() + '€'),
              background: Hero(
                tag: loadedBook.id,
                child: Image.network(
                  loadedBook.imageUrl,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10.0,),
              Center(
                child: Text(
                  loadedBook.title + "\n" + loadedBook.author,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      loadedBook.description,
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  )
              )
            ]),
          ),
        ],
    )
    );
  }
}
