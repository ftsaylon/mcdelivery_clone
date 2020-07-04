import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/providers/categories.dart';
import 'package:mcdelivery_clone/providers/product.dart';
import 'package:mcdelivery_clone/providers/products.dart';
import 'package:mcdelivery_clone/screens/cart_screen.dart';
import 'package:mcdelivery_clone/screens/menu_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'Food Delivery',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.yellow,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MenuScreen(),
        routes: {
          MenuScreen.routeName: (context) => MenuScreen(),
          CartScreen.routeName: (context) => CartScreen(),
        },
      ),
    );
  }
}
