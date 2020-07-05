import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcdelivery_clone/providers/order.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class OrderListItem extends StatefulWidget {
  const OrderListItem({Key key}) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<Order>(context);

    return Container(
      child: Card(
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('\$${order.amount}'),
              subtitle: Text(
                DateFormat('dd/MM/yyyy hh:mm').format(order.dateCreated),
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: order.products
                      .map(
                        (product) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              product.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${product.quantity}x \$${product.price}',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
