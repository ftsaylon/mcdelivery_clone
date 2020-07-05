import 'package:flutter/material.dart';
import '../models/category.dart';

import '../dummy_data.dart';

class Categories with ChangeNotifier {
  List<Category> _items = [...dummyCategories];

  List<Category> get items {
    return [..._items];
  }

  Category findById(String id) {
    return _items.firstWhere((category) => category.id == id);
  }
}
