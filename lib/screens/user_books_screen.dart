import 'package:bookshop/screens/edit_book_screen.dart';
import 'package:bookshop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/user_book_item.dart';

class UserBooksScreen extends StatelessWidget {
  static const routeName = '/user-books';

  Future<void> _refreshBooks(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetBooks(true);
  }

  @override
  Widget build(BuildContext context) {
    print('rebuilding...');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Books'),
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
      body: FutureBuilder(
        future: _refreshBooks(context),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting ? Center(
          child: CircularProgressIndicator(),
        ) : RefreshIndicator(
          onRefresh: () => _refreshBooks(context),
          child: Consumer<Products>(
            builder: (ctx, productsData, _) => Padding(
              padding: EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.items.length,
                itemBuilder: (_, i) =>
                    Column(
                      children: <Widget>[
                    UserBookItem(
                        productsData.items[i].id,
                        productsData.items[i].title,
                        productsData.items[i].imageUrl
                    ),
                        Divider()
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
