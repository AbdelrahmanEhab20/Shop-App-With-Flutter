import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductWidget extends StatelessWidget {
  final bool showFavs;
  ProductWidget(this.showFavs);
  @override
  Widget build(BuildContext context) {
    // Instance of classs with genereic of(Context) to listen on ProductsProvider
    final AccessProductsData = Provider.of<ProductsProvider>(context);
    // Get The list of the getter in the provider class
    final loadedProducts = showFavs
        ? AccessProductsData.favoritesItems
        : AccessProductsData.loadedItems;
    /******************************************************************************* */
    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        //How Each Grid Will be built handled by girdDelegate
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
        itemBuilder: ((ctx, index) => ChangeNotifierProvider.value(
              value: loadedProducts[index],
              //Will Get The Data through providers instead constructor and to start dealing with is favorite property of the class
              child: ProductItem(),
              // loadedProducts[index].id,
              // loadedProducts[index].imageUrl, loadedProducts[index].title
            )));
  }
}
