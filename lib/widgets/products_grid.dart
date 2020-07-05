import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../widgets/product_grid_item.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

import 'product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({Key key, this.categoryId}) : super(key: key);

  final categoryId;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    return StreamBuilder(
      stream: productsData.streamProductsByCategory(categoryId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Product> products = snapshot.data;
        return GridView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: products.length,
          itemBuilder: (context, index) => ProductGridItem(
            product: products[index],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        );
      },
    );
  }
}
