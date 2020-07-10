import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../constant.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart'),
    ),
    body: Column(
      children: <Widget>[
        Card(margin: EdgeInsets.all(10.0),
        child: Padding(padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Total',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              width: 10.0,
            ),
            Spacer(),
            Chip(
              label: Text(cart.totalAmount.toString()),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            FlatButton(
              child: Text('ORDER NOW'),
              onPressed: (){
                Provider.of<Orders>(context, listen: false).addOrder(cart.items.values.toList(), cart.totalAmount,);
              cart.clearCart();
                },
              textColor: backgroundColor,
            )
          ],
        ),
        ),
        ),
        SizedBox(height: 10.0),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.values.toList()[i].pricePerOne,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].author,
                cart.items.keys.toList()[i],
            ),
          ),
        )
      ],
    ),);
  }
}
