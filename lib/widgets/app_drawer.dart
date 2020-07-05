import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Hello, Customer!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Order History'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
