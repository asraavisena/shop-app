import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final List<CartItem> products;
  final DateTime dateTime;
  final double amount;

  OrderItem(
      {required this.id,
      required this.products,
      required this.amount,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  // ! CARANYA MIRIP KAYA PRODUCTS
  // ! NTAR COBA PAKE CARA LAIN YANG KAYA DI PRODUCT LIAT DI VIDEO SECTION 11 NO 271
  String? authToken;

  Orders(this.authToken, this._orders);
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            products: cartProducts,
            amount: total,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
