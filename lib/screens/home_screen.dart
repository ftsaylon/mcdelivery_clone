import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/models/category.dart';
import 'package:mcdelivery_clone/providers/categories.dart';
import 'package:mcdelivery_clone/providers/product.dart';
import 'package:mcdelivery_clone/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text('Add Product'),
      ),
    );
  }
}
