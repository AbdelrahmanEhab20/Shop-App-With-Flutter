import 'package:flutter/material.dart';
import '../screens/product_details_screen.dart';

class ProductItem extends StatelessWidget {
  //we can get all the product property
  //but we want only some of them
  final String id;
  final String title;
  final String imageUrl;

  //Constructor
  ProductItem(this.id, this.imageUrl, this.title);
  @override
  Widget build(BuildContext context) {
    
    /******************************************************************************* */
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          //only will pass the id to search with it in what we need from the list
          Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: id);
        },
        child: GridTile(
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
              trailing: IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
              leading: IconButton(
                color: Theme.of(context).accentColor,
                icon: Icon(Icons.favorite_sharp),
                onPressed: () {},
              ),
              backgroundColor: Colors.black87,
              title: Text(
                title,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }
}
