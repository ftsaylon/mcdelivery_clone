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
    final orders = Provider.of<Orders>(context).items;
    return Container(
      child: (orders.length > 0)
          ? ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                value: orders[index],
                child: OrderListItem(),
              ),
            )
          : Center(
              child: Text('No Orders yet'),
            ),
    );
  }
}
