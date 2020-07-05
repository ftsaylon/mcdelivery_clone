import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'product.dart';

import '../dummy_data.dart';

class Products with ChangeNotifier {
  final Firestore _db = Firestore.instance;

  List<Product> _items = [
    ...dummyProducts,
  ];

  List<Product> get items {
    return [..._items];
  }

  Stream<Product> streamProduct(String id) {
    return _db
        .collection('products')
        .document(id)
        .snapshots()
        .map((document) => Product.fromFirestore(document));
  }

  Stream<List<Product>> streamProducts() {
    var reference = _db.collection('products');
    return reference.snapshots().map((list) => list.documents
        .map((document) => Product.fromFirestore(document))
        .toList());
  }

  Stream<List<Product>> streamProductsByCategory(String categoryId) {
    var reference =
        _db.collection('products').where('categoryId', isEqualTo: categoryId);
    return reference.snapshots().map((list) => list.documents
        .map((document) => Product.fromFirestore(document))
        .toList());
  }

  // List<Product> getProductsByCategory(String categoryId) {
  //   return [..._items.where((product) => product.categoryId == categoryId)];
  // }

  // List<Product> get favoriteItems {
  //   return _items.where((product) => product.isFavorite).toList();
  // }

  // Future<void> toggleFavoriteStatus(String id) async {
  //   final product = findById(id);
  //   product..toggleFavoriteStatus();
  //   notifyListeners();
  // }
}
