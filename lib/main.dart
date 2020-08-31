import 'package:bookshop/screens/cart_screen.dart';
import 'package:bookshop/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'constant.dart';
import 'providers/auth.dart';
import 'screens/product_screen.dart';
import 'screens/book_detail_screen.dart';
import 'providers/products.dart';
import 'package:provider/provider.dart';
import 'providers/cart.dart';
import 'screens/cart_screen.dart';
import 'providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/user_books_screen.dart';
import './screens/edit_book_screen.dart';
import './screens/auth_screen.dart';
import 'screens/splash_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            //create: (_) => Products(),
            update: (ctx, auth, previousBooks) => Products(
                auth.token,
                previousBooks == null ? [] : previousBooks.items,
                auth.userId,
            ),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            //create: (_) => Orders(),
            update: (ctx, auth, previousOrders) => Orders(
                auth.token,
                auth.userId,
                previousOrders == null ? [] : previousOrders.orders,
            ),
          ),
    ],
      child: Consumer<Auth>(builder: (ctx, authData, _) => MaterialApp(
        title: 'BookShop',
        theme: ThemeData(
          primaryColor: darkBackgroundColor,
          accentColor: backgroundColor,

        ),
        home: authData.isAuth ? ProductsScreen() : FutureBuilder(
          future: authData.autoLogin(),
          builder: (ctx, authResultSnapshot) =>
          authResultSnapshot.connectionState == ConnectionState.waiting ?
          SplashScreen() :
          AuthScreen(),
        ),
        routes: {
          BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
          CartScreen.routeName: (ctx)  => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserBooksScreen.routeName: (ctx) => UserBooksScreen(),
          EditBookScreen.routeName: (ctx) => EditBookScreen(),

        },
      ),)
    );
  }
}


