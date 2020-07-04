import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'product.dart';

import 'package:mcdelivery_clone/dummy_data.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    ...dummyProducts,
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  List<Product> getProductsByCategory(String categoryId) {
    return [..._items.where((product) => product.categoryId == categoryId)];
  }

  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      categoryId: product.categoryId,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: Uuid().v1(),
    );
    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    if (productIndex >= 0) {
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final productIndex = _items.indexWhere((product) => product.id == id);
    _items.removeAt(productIndex);
    notifyListeners();
  }

  void toggleFavoriteStatus(String id) {
    findById(id).toggleFavoriteStatus();
    notifyListeners();
  }
}
