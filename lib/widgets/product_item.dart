import 'package:flutter/material.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  //we can get all the product property
  //but we want only some of them
  // final String id;
  // final String title;
  // final String imageUrl;

  //Constructor
  // ProductItem(this.id, this.imageUrl, this.title);
  @override
  Widget build(BuildContext context) {
    /******************************************************************************* */
    //Provider used instead of passing the data through constructor

    // back to use the data came from provider and listen to it's changes
    // instead of consumer because it makes the toggle to lag
    final productItemData = Provider.of<Product>(context);
    //Cart Provider accessing it here
    // we are not interested here to changes in the cart
    final cartData = Provider.of<CartProvider>(context, listen: false);
    //print("Testing Consumer Ane Provider");
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          //only will pass the id to search with it in what we need from the list
          Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,
              arguments: productItemData.id);
        },
        child: GridTile(
          child: Image.network(
            productItemData.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
              trailing: IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cartData.addItem(productItemData.id, productItemData.price,
                      productItemData.title);
                },
              ),
              //Consumer was here only to listen to this widget on the tree only
              leading: IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(productItemData.isFavorite
                    ? Icons.favorite_sharp
                    : Icons.favorite_border),
                onPressed: () {
                  productItemData.toggleFavoriteStatus();
                },
              ),
              backgroundColor: Colors.black87,
              title: Text(
                productItemData.title,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
