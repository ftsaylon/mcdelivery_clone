import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/providers/orders.dart';
import 'package:mcdelivery_clone/widgets/order_list_item.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    // final orders = Provider.of<Orders>(context).items;
    return FutureBuilder(
      future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.error != null) {
            // ...
            // Do error handling stuff
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<Orders>(
              builder: (context, orderData, child) => ListView.builder(
                itemCount: orderData.items.length,
                itemBuilder: (context, index) =>
                    OrderListItem(order: orderData.items[index]),
              ),
            );
          }
        }
      },
    );
  }
}
