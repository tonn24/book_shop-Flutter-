import 'package:bookshop/helpers/custom_route.dart';
import 'package:flutter/material.dart';
import '../screens/user_books_screen.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_route.dart';
import '../screens/orders_screen.dart';


class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Column(
      children: <Widget>[
        AppBar(
          title: Text('Hello'),
          automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.payment),
          title: Text('Orders'),
          onTap: () {
            //Navigator.of(context).pushReplacementNamed(OrdersScreen.routeName);
            Navigator.of(context).pushReplacement(CustomRoute(builder: (ctx) => OrdersScreen(),));
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.edit),
          title: Text('Manage Books'),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(UserBooksScreen.routeName);
          },
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Log out'),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    ),
    );
  }
}
