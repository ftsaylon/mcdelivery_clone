import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details_screen.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context, listen: false);

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
            ),
          ),
        );
      },
      child: GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (product.imageUrl != null)
              Expanded(
                child: Image.network(
                  product.imageUrl,
                ),
              ),
            Text(
              product.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              currencyFormat.format(product.price),
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
