import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  // final String title;
  // final double price;
  // ProductDetailsScreen(this.title, this.price);
  static const routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context).settings.arguments as String;
    //... get data by the id
    /******************************************************************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        centerTitle: true,
      ),
      body: Text(''),
    );
    ;
  }
}
