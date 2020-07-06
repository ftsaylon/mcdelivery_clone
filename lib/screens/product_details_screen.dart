import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/products.dart';

import '../screens/main_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key key}) : super(key: key);

  static const routeName = '/product-details';

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  var _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final productId = ModalRoute.of(context).settings.arguments;
    final product = productsData.findById(productId);

    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);

    Locale locale = Localizations.localeOf(context);
    final currencyFormat = NumberFormat.simpleCurrency(
      locale: locale.toString(),
    );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/images/logo/simple_logo.png',
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Text('McDelivery'),
          ],
        ),
      ),
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
                      if (product.imageUrl != null)
                        Image.network(product.imageUrl),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            product.title,
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
                          (product.isFavorite)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          productsData.toggleFavoriteStatus(
                            authData.token,
                            authData.userId,
                            product.id,
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            currencyFormat.format(product.price * _quantity),
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
                    product.id,
                    product.price,
                    product.title,
                    product.imageUrl,
                    quantity: _quantity,
                  );
                  _showAlertDialog(context);
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

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 150,
                padding: EdgeInsets.all(10),
                child: Image.asset('assets/images/cart.png'),
              ),
              Text(
                'Added to Cart!',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Text(
                    'ADD MORE PRODUCTS',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(
                          initialIndex: 2,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'PROCEED TO CHECKOUT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
