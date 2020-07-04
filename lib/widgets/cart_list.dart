import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mcdelivery_clone/providers/cart.dart';

import 'cart_list_item.dart';

class CartList extends StatelessWidget {
  const CartList({Key key, this.categoryId}) : super(key: key);

  final categoryId;

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final cart = cartData.items;

    return (cart.isNotEmpty)
        ? ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              return CartListItem(
                id: cart.values.toList()[index].id,
                productId: cart.keys.toList()[index],
                title: cart.values.toList()[index].title,
                price: cart.values.toList()[index].price,
                quantity: cart.values.toList()[index].quantity,
                imageUrl: cart.values.toList()[index].imageUrl,
              );
            },
          )
        : Center(
            child: Text('No items yet'),
          );
  }
}
