import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/providers/auth.dart';
import 'package:mcdelivery_clone/providers/orders.dart';
import './providers/categories.dart';
import './providers/products.dart';
import './screens/cart_screen.dart';
import './screens/menu_screen.dart';
import './screens/product_details_screen.dart';
import 'package:provider/provider.dart';

import 'providers/cart.dart';
import 'screens/auth_screen.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products('', '', []),
          update: (_, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts.items,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Categories>(
          create: (_) => Categories('', []),
          update: (_, auth, previousCategories) => Categories(
            auth.token,
            previousCategories.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders('', '', []),
          update: (_, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders.items,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'Food Delivery',
          theme: ThemeData(
            primarySwatch: Colors.red,
            accentColor: Colors.yellow,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? MainScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            MainScreen.routeName: (context) => MainScreen(),
            MenuScreen.routeName: (context) => MenuScreen(),
            CartScreen.routeName: (context) => CartScreen(),
            ProductDetailsScreen.routeName: (context) => ProductDetailsScreen(),
          },
        ),
      ),
    );
  }
}
