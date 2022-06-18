import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total : ',
                    style: TextStyle(fontSize: 20),
                  ),
                  //like badge or label, element with rounded corner
                  //used to display information
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'ORDER NOW',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, index) {
                return CartItemCard(
                    cart.cartItemsCopy.values.toList()[index].id,
                    //passing the key here as a product Id to be deleted
                    cart.cartItemsCopy.keys.toList()[index],
                    cart.cartItemsCopy.values.toList()[index].title,
                    cart.cartItemsCopy.values.toList()[index].quantity,
                    cart.cartItemsCopy.values.toList()[index].price);
              },
            ),
          )
        ],
      ),
    );
  }
}
