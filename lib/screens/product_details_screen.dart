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
      // appBar: AppBar(
      //   title: Text(loadedProducts.title),
      //   centerTitle: true,
      // ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProducts.title!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w900),
              ),
              background: Hero(
                tag: loadedProducts.id!,
                child: Image.network(
                  loadedProducts.imageUrl!,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          SliverList(
            //to tell how to render the content
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProducts.price}',
                style: TextStyle(
                    color: Color.fromARGB(255, 53, 51, 51), fontSize: 25),
                textAlign: TextAlign.center,
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
              SizedBox(
                height: 800,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
