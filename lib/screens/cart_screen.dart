import 'package:flutter/material.dart';
import 'package:myshop/providers/orders_provider.dart';
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
            margin: EdgeInsets.all(10),
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
                    //Decimel two digit only
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OrderButton(cart: cart)
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              softWrap: true,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              // Fire The Add Function in the order provider.
              //not interseted in changes listen:false
              await Provider.of<OrdersProvider>(context, listen: false)
                  .addNewOrder(widget.cart.cartItemsCopy.values.toList(),
                      widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });
              //after add the order clear the list
              widget.cart.clearListOfCart();
            },
    );
  }
}
