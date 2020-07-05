import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/screens/orders_screen.dart';
import '../screens/home_screen.dart';
import '../screens/menu_screen.dart';

import 'cart_screen.dart';

class MainScreen extends StatefulWidget {
  final initialIndex;

  MainScreen({
    Key key,
    this.initialIndex,
  }) : super(key: key);

  static const routeName = '/main';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /* -------------------------- Bottom Navigation Bar ------------------------- */
  int _selectedIndex;

  List<Widget> _widgetOptions = <Widget>[
    // HomeScreen(),
    MenuScreen(),
    OrdersScreen(),
    CartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems = [
    // BottomNavigationBarItem(
    //   icon: Icon(Icons.home),
    //   title: Text('Home'),
    // ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      title: Text('Menu'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      title: Text('Orders'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_basket),
      title: Text('Cart'),
    ),
  ];
/* -------------------------------------------------------------------------- */

  @override
  void initState() {
    _selectedIndex = widget.initialIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
