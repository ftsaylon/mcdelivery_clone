import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mcdelivery_clone/providers/orders.dart';

class OrderTrackerScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackerScreen({
    Key key,
    this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Orders>(context).findById(orderId);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay),
            onPressed: () {
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Track your McDo Order',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                'from our store to your door',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 12),
              Container(
                child: Image.asset('assets/images/order_tracker/step1.png'),
              ),
              Container(
                child: (order.isProcessed)
                    ? Image.asset('assets/images/order_tracker/step2.png')
                    : Image.asset(
                        'assets/images/order_tracker/step2-disabled.png'),
              ),
              Container(
                child: (order.isBeingPrepared)
                    ? Image.asset('assets/images/order_tracker/step3.png')
                    : Image.asset(
                        'assets/images/order_tracker/step3-disabled.png'),
              ),
              Container(
                child: (order.isOnTheWay)
                    ? Image.asset('assets/images/order_tracker/step4.png')
                    : Image.asset(
                        'assets/images/order_tracker/step4-disabled.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
