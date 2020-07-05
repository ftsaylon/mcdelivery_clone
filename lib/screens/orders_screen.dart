import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key key}) : super(key: key);

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
    );
  }
}
