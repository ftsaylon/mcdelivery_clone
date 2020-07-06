import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcdelivery_clone/providers/auth.dart';
import 'package:mcdelivery_clone/providers/orders.dart';
import 'package:mcdelivery_clone/screens/checkout_screen.dart';
import '../providers/cart.dart';
import '../widgets/cart/cart_list.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final orders = Provider.of<Orders>(context);
    final user = Provider.of<Auth>(context).user;

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return Column(
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
                  onPressed: (cart.items.isNotEmpty)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CheckoutScreen(
                                  cartProducts: cart.items.values.toList(),
                                  amount: cart.totalAmount,
                                  customerName:
                                      '${user.firstName} ${user.lastName}',
                                  address: user.address,
                                );
                              },
                            ),
                          );
                        }
                      : null,
                  child: Text(
                    'NEXT',
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
    );
  }
}
