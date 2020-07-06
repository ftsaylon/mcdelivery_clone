import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

import '../providers/auth.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/user';

  UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _lastNameFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedUser = User(
    id: null,
    userId: null,
    firstName: '',
    lastName: '',
    email: '',
    address: '',
  );

  var _initValues = {
    'firstName': '',
    'lastName': '',
    'address': '',
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _editedUser = Provider.of<Auth>(context).user;
      _initValues = {
        'firstName': _editedUser.firstName ?? '',
        'lastName': _editedUser.lastName ?? '',
        'address': _editedUser.address ?? '',
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _lastNameFocusNode.dispose();
    _addressFocusNode.dispose();
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
    if (_editedUser.id != null) {
      await Provider.of<Auth>(context, listen: false).updateUser(
        _editedUser.id,
        _editedUser,
      );
    }

    setState(() {
      _isInit = true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (!_isLoading)
        ? Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    initialValue: _initValues['firstName'],
                    decoration: InputDecoration(labelText: 'First Name'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastNameFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = User(
                        id: _editedUser.id,
                        userId: _editedUser.userId,
                        firstName: value,
                        lastName: _editedUser.lastName,
                        email: _editedUser.email,
                        address: _editedUser.address,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['lastName'],
                    decoration: InputDecoration(labelText: 'Last Name'),
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
                      _editedUser = User(
                        id: _editedUser.id,
                        userId: _editedUser.userId,
                        firstName: _editedUser.firstName,
                        lastName: value,
                        email: _editedUser.email,
                        address: _editedUser.address,
                      );
                    },
                  ),
                  TextFormField(
                    maxLines: 3,
                    initialValue: _initValues['address'],
                    decoration: InputDecoration(labelText: 'Address'),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please provide a value.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = User(
                        id: _editedUser.id,
                        userId: _editedUser.userId,
                        firstName: _editedUser.firstName,
                        lastName: _editedUser.lastName,
                        email: _editedUser.email,
                        address: value,
                      );
                    },
                  ),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _saveForm();
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
