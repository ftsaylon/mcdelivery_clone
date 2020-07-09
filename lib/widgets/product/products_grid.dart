import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products.dart';

import '../../widgets/product/product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key key, this.categoryId}) : super(key: key);

  final categoryId;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.getProductsByCategory(categoryId);

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products[index],
        child: ProductGridItem(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
