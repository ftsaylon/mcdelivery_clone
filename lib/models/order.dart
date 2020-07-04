import 'cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateCreated;

  Order({
    this.id,
    this.amount,
    this.products,
    this.dateCreated,
  });
}
