import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    Key key,
    this.product,
  }) : super(key: key);

  static const routeName = '/product-details';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var _quantity = 1;

  @override
  Widget build(BuildContext context) {
    // final product = ModalRoute.of(context).settings.arguments;
    final productsData = Provider.of<Products>(context);
    final cart = Provider.of<Cart>(context);

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      if (widget.product.imageUrl != null)
                        Image.network(widget.product.imageUrl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.product.title,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              _buildQuantitySelect(context),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          (widget.product.isFavorite)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          // productsData.toggleFavoriteStatus(widget.product.id);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            currencyFormat
                                .format(widget.product.price * _quantity),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              'Change to Value Meal',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  cart.addItem(
                    widget.product.id,
                    widget.product.price,
                    widget.product.title,
                    widget.product.imageUrl,
                    quantity: _quantity,
                  );
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ADD TO MY BAG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Theme.of(context).accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildQuantitySelect(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.remove_circle,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              if (_quantity > 1) {
                _quantity -= 1;
              }
            });
          },
        ),
        Text('$_quantity'),
        IconButton(
          icon: Icon(
            Icons.add_circle,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              _quantity += 1;
            });
          },
        )
      ],
    );
  }
}
