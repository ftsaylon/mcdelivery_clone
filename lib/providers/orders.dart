import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'order.dart';
import '../models/cart_item.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Order findById(String id) {
    return _items.firstWhere((order) => order.id == id);
  }

  Future<void> fetchAndSetOrders() async {
    var url =
        'https://mcdelivery-clone-customer-app.firebaseio.com/orders.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<Order> loadedOrders = [];
      extractedData.forEach((orderId, orderData) {
        loadedOrders.insert(
          0,
          Order(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    productId: item['productId'],
                    title: item['title'],
                    quantity: item['quantity'],
                    price: item['price'],
                    imageUrl: item['imageUrl'],
                  ),
                )
                .toList(),
            dateCreated: DateTime.parse(orderData['dateCreated']),
            isSubmitted: orderData['isSubmitted'],
            isProcessed: orderData['isProcessed'],
            isBeingPrepared: orderData['isBeingPrepared'],
            isOnTheWay: orderData['isOnTheWay'],
          ),
        );
      });
      _items = loadedOrders;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double amount) async {
    final url =
        'https://mcdelivery-clone-customer-app.firebaseio.com/orders.json';

    final timestamp = DateTime.now();

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'amount': amount,
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'productId': cartProduct.productId,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                    'imageUrl': cartProduct.imageUrl,
                  })
              .toList(),
          'dateCreated': timestamp.toIso8601String(),
          'isSubmitted': true,
          'isProcessed': false,
          'isBeingPrepared': false,
          'isOnTheWay': false,
        }),
      );

      print(response.body);

      final newOrder = Order(
        id: json.decode(response.body)['name'],
        amount: amount,
        products: cartProducts,
        dateCreated: timestamp,
        isSubmitted: true,
      );

      _items.insert(0, newOrder);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
