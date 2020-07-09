import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../providers/cart.dart';

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

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildListItem(context, cart, currencyFormat),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Edit',
          color: Colors.black45,
          icon: Icons.edit,
          onTap: () {},
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () {
            cart.removeItem(productId);
          },
        ),
      ],
    );
  }

  InkWell _buildListItem(
      BuildContext context, Cart cart, NumberFormat currencyFormat) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            ListTile(
              leading: (imageUrl != null) ? Image.network(imageUrl) : null,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              trailing: Column(
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
                          cart.addItem(productId, price, title, imageUrl);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Text(
                currencyFormat.format(price * quantity),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
