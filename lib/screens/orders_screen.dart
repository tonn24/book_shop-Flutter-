import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as ord;
import '../widgets/app_drawer.dart';


class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: ListView.builder(itemCount: orderdata.orders.length,
          itemBuilder: (ctx, i) => ord.OrderItem(orderdata.orders[i]),
        )
      );
  }
}
