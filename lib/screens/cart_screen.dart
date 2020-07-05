import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcdelivery_clone/providers/orders.dart';
import '../providers/cart.dart';
import '../widgets/cart_list.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'ORDER SUMMARY',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: CartList(),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Subtotal'),
                    Text(
                      currencyFormat.format(cart.subTotal),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Delivery Charge'),
                    Text(
                      currencyFormat.format(cart.deliveryCharge),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'GRAND TOTAL',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      currencyFormat.format(cart.totalAmount),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Divider(),
                Container(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      orders.addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
