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
  Widget build(BuildContext context) {
    print('Building orders!');
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
        builder: (ctx, data) {
          //This area needs fixing
          if (data.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if(data.error != null) {
              return Center(
              child: Text('An error has occured!'),
              );
            } else if(data.error == null) {
                return Consumer<Orders>(
                  builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, i) => ord.OrderItem(orderData.orders[i]),
                  ),
                );
              } else {
              return Center(
                child: Text(
                  'No books in your orders yet! ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
                  ),
                ),
              );
            }
            }
          }
      ),
    );
  }
}
