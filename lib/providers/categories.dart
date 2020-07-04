import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/models/category.dart';

import 'package:mcdelivery_clone/dummy_data.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [...dummyCategories];

  List<Category> get items {
    return [..._items];
  }

  Category findById(String id) {
    return _items.firstWhere((category) => category.id == id);
  }
}
