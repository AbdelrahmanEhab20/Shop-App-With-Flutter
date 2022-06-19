import 'package:flutter/material.dart';
import 'package:myshop/widgets/side_App_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';

//we will show list of products here and for each one we can update and delete
//future features will be authentication to manage all of that

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Your Products'), actions: [
        IconButton(
          onPressed: () {
            //-------------
          },
          icon: Icon(Icons.add),
        )
      ]),
      drawer: SideAppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsData.loadedItems.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                UserProductItem(
                    productsData.loadedItems[index].title,
                    productsData.loadedItems[index].imageUrl,
                    productsData.loadedItems[index].description),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
