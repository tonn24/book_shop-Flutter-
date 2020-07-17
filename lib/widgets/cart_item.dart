import 'package:flutter/material.dart';
import '../constant.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String bookId;
  final double price;
  final int quantity;
  final String title;
  final String author;


  CartItem(this.id, this.price, this.quantity, this.title, this.author, this.bookId);

  @override
  Widget build(BuildContext context) {
    double total = price * quantity;
      return Dismissible(
        key: ValueKey(id),
        background: Container(
        color: Theme.of(context).errorColor,
          child: Icon(Icons.delete,
              color: Colors.white,
              size: 40.0,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 15.0),
          margin: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 4.0,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(context: context, builder: (ctx) => AlertDialog(
            title: Text('Are you sure'),
            content: Text('Do you want to remove the book from the cart'),
            actions: <Widget>[
              FlatButton(child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
              ),
              FlatButton(child: Text('yes'),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              }
              )
            ],
          ));
        },
        onDismissed: (direction) {
          Provider.of<Cart>(context,  listen: false).removeItem(bookId);
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 4.0,
    ),
          child: Padding(padding: EdgeInsets.all(10),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: darkBackgroundColor,
                child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: FittedBox(child: Text('\$$price'))),),
              title: Text(title),
              subtitle: Text('Total: \$${(double.parse((total).toStringAsFixed(2)))}'),
              trailing: Text('$quantity x'),
            ),
          ),
    ),
      );
  }
}
