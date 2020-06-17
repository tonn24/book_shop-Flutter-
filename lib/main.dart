import 'package:flutter/material.dart';
import 'constant.dart';
import 'screens/product_screen.dart';
import 'screens/book_detail_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'BookShop',
        theme: ThemeData(
          primaryColor: darkBackgroundColor,
          accentColor: backgroundColor,
          //fontFamily: 'Lato',
        ),
        home: ProductsScreen(),
        routes: {
          BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
        },
      ),
    );
  }
}


