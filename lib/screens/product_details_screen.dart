import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // ProductDetailsScreen(this.title, this.price);
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    // Get The Id To search on  the list of products with it.
    /*??????????????????????????????????????????????????--------why--------?????????????????????????????????????????????????????*/
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // Get the list from the provider to start get what we need
    // and access the new method inside providers that return items with the id we search by...
    final loadedProducts = Provider.of<ProductsProvider>(context, listen: false)
        .findByID(productId);
    /******************************************************************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
        centerTitle: true,
      ),
      body: Center(child: Text(loadedProducts.title)),
    );
    ;
  }
}
