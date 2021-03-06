import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/cart_item.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  double _deliveryCharge = 49;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get deliveryCharge {
    return _deliveryCharge;
  }

  double get totalAmount {
    var total = subTotal + deliveryCharge;
    return total;
  }

  double get subTotal {
    var subTotal = 0.0;
    _items.forEach((key, cartItem) {
      subTotal += cartItem.price * cartItem.quantity;
    });
    return subTotal;
  }

  void addItem(
    String productId,
    double price,
    String title,
    String imageUrl, {
    int quantity,
  }) {
    if (_items.containsKey(productId)) {
      if (quantity == null) quantity = 1;
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          productId: existingCartItem.productId,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + quantity,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: Uuid().v1(),
          productId: productId,
          title: title,
          quantity: quantity ?? 1,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId))
      return;
    else if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
          price: existingCartItem.price,
          imageUrl: existingCartItem.imageUrl,
        ),
      );
    } else if (_items[productId].quantity == 1) {
      removeItem(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
