import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category.dart';

import '../providers/products.dart';
import '../providers/categories.dart';

import '../screens/category_tab.dart';

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

  var _isLoading = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts();
      Provider.of<Categories>(context).fetchAndSetCategories().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }

    categories = Provider.of<Categories>(context).items;
    categoryTabs = categories.map((category) {
      return Tab(
        text: category.title.toUpperCase(),
      );
    }).toList();

    _tabController = TabController(vsync: this, length: categoryTabs.length);
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (!_isLoading)
          ? Column(
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
