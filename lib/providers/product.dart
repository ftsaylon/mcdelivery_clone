import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String categoryId;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.categoryId,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  // void _setFavoriteValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }

  void toggleFavoriteStatus() {
    // final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    print(isFavorite);
    notifyListeners();
  }
}
