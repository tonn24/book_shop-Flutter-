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
            OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {

  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;


  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null : () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false)
            .addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount,);
        setState(() {
          _isLoading = false;
        });
      widget.cart.clearCart();
        },
      textColor: backgroundColor,
    );
  }
}
