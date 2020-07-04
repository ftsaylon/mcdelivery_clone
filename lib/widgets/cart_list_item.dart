import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mcdelivery_clone/models/cart_item.dart';
import 'package:mcdelivery_clone/providers/cart.dart';
import 'package:provider/provider.dart';

class CartListItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  final String imageUrl;

  const CartListItem({
    Key key,
    this.id,
    this.productId,
    this.price,
    this.quantity,
    this.title,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return ListTile(
      leading: Column(
        children: <Widget>[
          if (imageUrl != null) Image.network(imageUrl),
          FlatButton(
            onPressed: () {},
            child: Text('EDIT'),
          )
        ],
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            currencyFormat.format(price),
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
      trailing: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    cart.removeSingleItem(productId);
                  },
                ),
                Text('$quantity'),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    cart.addItem(productId, price, title);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
