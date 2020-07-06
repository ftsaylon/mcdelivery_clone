import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';

import '../widgets/order/order_list_item.dart';

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
            print(snapshot.error);
            // ...
            // Do error handling stuff
            return Center(
              child: Text('An error occurred!'),
            );
          } else {
            return Consumer<Orders>(builder: (context, orderData, child) {
              return (orderData.items.length > 0)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(24),
                          child: Text(
                            'ORDER HISTORY',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: orderData.items.length,
                            itemBuilder: (context, index) =>
                                OrderListItem(order: orderData.items[index]),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Text(
                        'You Have No Orders Yet!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
            });
          }
        }
      },
    );
  }
}
