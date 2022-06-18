import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  //Get copy as we do on the other providers to deal
  //with the list here not in the original one
  List<OrderItem> get ordersCopy {
    return [..._orders];
  }

  //add new Order
  void addNewOrder(List<CartItem> cardProducts, double total) {
    // we can use add or at the top at index 0 with insert
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            products: cardProducts,
            dateTime: DateTime.now()));
    notifyListeners();
  }
}
