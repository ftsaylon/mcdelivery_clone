import 'package:flutter/material.dart';

import '../models/cart_item.dart';

class Order with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateCreated;
  bool isSubmitted = false;
  bool isProcessed = false;
  bool isBeingPrepared = false;
  bool isOnTheWay = false;

  Order({
    this.id,
    this.amount,
    this.products,
    this.dateCreated,
    this.isSubmitted,
    this.isProcessed,
    this.isBeingPrepared,
    this.isOnTheWay,
  });
}
