import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'order.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
  ) {
    final timestamp = DateTime.now();
    _items.insert(
      0,
      Order(
        id: Uuid().v1(),
        amount: total,
        dateCreated: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
