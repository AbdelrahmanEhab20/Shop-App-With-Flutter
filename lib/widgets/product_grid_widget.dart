import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import './product_item.dart';

class ProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AccessProductsData = Provider.of<ProductsProvider>(context);
    // Get The list of the getter in the provider class
    final loadedProducts = AccessProductsData.loadedItems;
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
        itemBuilder: ((ctx, index) => ProductItem(loadedProducts[index].id,
            loadedProducts[index].imageUrl, loadedProducts[index].title)));
  }
}
