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
    @required this.id,
    @required this.title,
    @required this.categoryId,
    @required this.description,
    @required this.price,
    this.imageUrl,
    this.isFavorite,
  });

  // void _setFavoriteValue(bool newValue) {
  //   isFavorite = newValue;
  //   notifyListeners();
  // }
}
