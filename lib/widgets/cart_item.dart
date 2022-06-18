import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItemCard extends StatelessWidget {
  final String? id;
  final String? productId;
  final String? title;
  final int? quantity;
  final double? price;
  CartItemCard(this.id, this.productId, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete_forever_sharp,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
      ),
      direction: DismissDirection.endToStart,
      //Function to delete the whole item with all of it's quantity
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItem(productId!);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text('\$${price}')),
              ),
            ),
            title: Text(title!),
            subtitle: Text('Total : \$${(price! * quantity!)}'),
            trailing: Text('${quantity} X'),
          ),
        ),
      ),
    );
  }
}
