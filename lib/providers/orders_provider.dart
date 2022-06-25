import 'dart:convert';

import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import 'package:http/http.dart' as http;

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

  final String? _authToken;
  OrdersProvider(this._authToken, this._orders);
  //add new Order
  Future<void> addNewOrder(List<CartItem> cardProducts, double total) async {
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com',
        '/orders.json',
        {'auth': '$_authToken'});
    final timestamp = DateTime.now();
    final response = await http.post(urlCallServer,
        body: json.encode({
          'amount': total,
          'dataTime': timestamp.toIso8601String(),
          'products': cardProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price
                  })
              .toList(),
        }));
    // we can use add or at the top at index 0 with insert
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cardProducts,
            dateTime: timestamp));
    notifyListeners();
  }

  //Fetch Order And Set in a place to show
  Future<void> fetchAndSetOrders() async {
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com',
        '/orders.json',
        {'auth': '$_authToken'});
    final response = await http.get(urlCallServer);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    ;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dataTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['id'],
                  price: item['price'],
                  quantity: item['quantity'],
                  title: item['title'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
    // print(json.decode(response.body));
  }
}
