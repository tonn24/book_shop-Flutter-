import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart' as ord;
import '../widgets/app_drawer.dart';


class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchAndSetOrder();
      setState(() {
        _isLoading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders')
      ),
      drawer: AppDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator()) : orderdata.orders.length <= 0 ? Center(
        child: Text(
            'You have no books in your orders yet!',
          style: TextStyle(
            height: 22,
            color: Colors.grey,
            fontSize: 20.0,
          ),
        ),
      ) : ListView.builder(
        itemCount: orderdata.orders.length,
          itemBuilder: (ctx, i) => ord.OrderItem(orderdata.orders[i]),
        )
      );
  }
}
