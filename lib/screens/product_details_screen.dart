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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                padding: EdgeInsets.all(20),
                height: 300,
                width: double.infinity,
                child: Image.network(
                  loadedProducts.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '\$${loadedProducts.price}',
              style: TextStyle(
                  color: Color.fromARGB(255, 53, 51, 51), fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                '${loadedProducts.description}',
                style: TextStyle(fontSize: 25),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
