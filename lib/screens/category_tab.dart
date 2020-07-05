import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({Key key, this.categoryId}) : super(key: key);

  final categoryId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8.0),
      child: ProductsGrid(
        categoryId: categoryId,
      ),
    );
  }
}
