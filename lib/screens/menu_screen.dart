import 'package:flutter/material.dart';
import 'package:mcdelivery_clone/models/category.dart';
import 'package:mcdelivery_clone/providers/categories.dart';
import 'package:mcdelivery_clone/screens/cart_screen.dart';
import 'package:mcdelivery_clone/screens/category_tab.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key}) : super(key: key);

  static const routeName = '/menu';

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  List<Category> categories;
  List<Tab> categoryTabs;

  TabController _tabController;

  @override
  void didChangeDependencies() {
    categories = Provider.of<Categories>(context, listen: false).items;

    categoryTabs = categories.map((category) {
      return Tab(
        text: category.title.toUpperCase(),
      );
    }).toList();

    _tabController = TabController(vsync: this, length: categoryTabs.length);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_basket),
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Center(
              child: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: categoryTabs,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: categories.map((category) {
                  return CategoryTab(
                    categoryId: category.id,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
