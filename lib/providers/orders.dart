import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/order.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
  ) {
    final timestamp = DateTime.now();
    _orders.insert(
      0,
      Order(
        id: Uuid().v1(),
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
