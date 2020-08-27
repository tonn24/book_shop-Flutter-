import 'package:bookshop/screens/edit_book_screen.dart';
import 'package:bookshop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/user_book_item.dart';

class UserBooksScreen extends StatelessWidget {
  static const routeName = '/user-books';

  Future<void> _refreshBooks(BuildContext context) async {
    Provider.of<Products>(context).fetchAndSetBooks(true);
  }

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Books'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.of(context).pushNamed(EditBookScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshBooks(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: books.items.length,
            itemBuilder: (_, i) =>
                Column(
                  children: <Widget>[
                UserBookItem(
                    books.items[i].id,
                    books.items[i].title,
                    books.items[i].imageUrl),
                    Divider()
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
