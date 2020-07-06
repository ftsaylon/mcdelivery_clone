import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart_item.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/orders.dart';

import 'order_tracker_screen.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = '/user';

  final List<CartItem> cartProducts;
  final double amount;
  final String customerName;
  final String address;

  CheckoutScreen({
    Key key,
    this.cartProducts,
    this.amount,
    this.customerName,
    this.address,
  }) : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _addressFocusNode = FocusNode();
  final _remarksFocusNode = FocusNode();
  final _changeForFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _initValues = {
    'products': [],
    'amount': '',
    'customerName': '',
    'address': '',
    'remarks': '',
    'changeFor': '',
  };

  var _isLoading = false;

  @override
  void initState() {
    _initValues = {
      'products': widget.cartProducts ?? [],
      'amount': widget.amount ?? '',
      'customerName': widget.customerName ?? '',
      'address': widget.address ?? '',
      'remarks': '',
      'changeFor': '',
    };
    super.initState();
  }

  @override
  void dispose() {
    _remarksFocusNode.dispose();
    _addressFocusNode.dispose();
    _changeForFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });

    try {
      final orderId =
          await Provider.of<Orders>(context, listen: false).addOrder(
        _initValues['products'],
        _initValues['amount'],
        _initValues['customerName'],
        _initValues['address'],
        _initValues['remarks'],
        double.parse(_initValues['changeFor']),
      );
      Provider.of<Cart>(context, listen: false).clear();
      Navigator.of(context).popUntil(
        ModalRoute.withName('/'),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderTrackerScreen(
            orderId: orderId,
          ),
        ),
      );
    } catch (error) {
      throw (error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: (!_isLoading)
          ? Container(
              padding: EdgeInsets.all(24),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    Text(
                      'CHECKOUT',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      initialValue: _initValues['customerName'],
                      decoration: InputDecoration(labelText: 'Customer Name'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addressFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _initValues = {
                            'products': _initValues['products'],
                            'amount': _initValues['amount'],
                            'customerName': value,
                            'address': _initValues['address'],
                            'remarks': _initValues['remarks'],
                            'changeFor': _initValues['changeFor'],
                          };
                        });
                      },
                    ),
                    TextFormField(
                      maxLines: 3,
                      initialValue: _initValues['address'],
                      decoration: InputDecoration(labelText: 'Address'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_remarksFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _initValues = {
                            'products': _initValues['products'],
                            'amount': _initValues['amount'],
                            'customerName': _initValues['customerName'],
                            'address': value,
                            'remarks': _initValues['remarks'],
                            'changeFor': _initValues['changeFor'],
                          };
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['remarks'],
                      decoration: InputDecoration(labelText: 'Remarks'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_changeForFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _initValues = {
                            'products': _initValues['products'],
                            'amount': _initValues['amount'],
                            'customerName': _initValues['customerName'],
                            'address': _initValues['address'],
                            'remarks': value,
                            'changeFor': _initValues['changeFor'],
                          };
                        });
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['changeFor'].toString(),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Change For'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        if (double.parse(value) < _initValues['amount']) {
                          return 'Please provide a value larger than ${_initValues['amount']}';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _initValues = {
                            'products': _initValues['products'],
                            'amount': _initValues['amount'],
                            'customerName': _initValues['customerName'],
                            'address': _initValues['address'],
                            'remarks': _initValues['remarks'],
                            'changeFor': value,
                          };
                        });
                      },
                    ),
                    RaisedButton(
                      color: Theme.of(context).accentColor,
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        _saveForm();
                      },
                      child: Text(
                        'PLACE ORDER',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
