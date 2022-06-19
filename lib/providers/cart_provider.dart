import 'package:flutter/material.dart';

//Class For define how the cart will be shown
class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id,
      required this.price,
      required this.quantity,
      required this.title});
}

//class provider for the cart
class CartProvider with ChangeNotifier {
  // ----Late--- => Allow this to be null for now,
  //compiler trusts us, that we will assign it.
  late Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItemsCopy {
    return {..._cartItems};
  }

  //Counting the amount of the items in cart
  int get itemCount {
    return _cartItems.length;
  }

  //Total amount of Items
  double get totalAmount {
    var total = 0.0;
    //That's for all elements in list ,so we wil use foreach()
    // excute function on every entry in the map
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_cartItems.containsKey(productId)) {
      // Change The Quantity of that item if found here
      // if we found the item then increase the quantity of it
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              price: existingCartItem.price,
              title: existingCartItem.title,
              quantity: existingCartItem.quantity + 1));
    } else {
      //Look up the value of [key],
      //or add a new entry if it isn't there.
      _cartItems.putIfAbsent(
          productId,
          () => CartItem(
              //id new for the new item
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1));
    }
    notifyListeners();
  }

  //remove single item
  void removeSingleItem(String productId) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId]!.quantity > 1) {
      _cartItems.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price,
                quantity: existingCartItem.quantity - 1,
              ));
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  //Remove Item By The Dismissable
  void removeItem(String productID) {
    _cartItems.remove(productID);
    notifyListeners();
  }
  //Remove one quantity of an Item By ICon delete in card
  //-------------

  //Clear The Cart After Making Order
  void clearListOfCart() {
    _cartItems = {};
    notifyListeners();
  }
}
