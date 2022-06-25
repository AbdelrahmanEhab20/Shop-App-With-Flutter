import 'package:flutter/material.dart';
import '../widgets/side_App_drawer.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

//we will show list of products here and for each one we can update and delete
//future features will be authentication to manage all of that

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  // function for refreshinng data of products by api
  Future<void> _refreshAndFetchData(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsData = Provider.of<ProductsProvider>(context);
    print('REBUILDING...................');
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Your Products'), actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(EditUserProductScreen.routeName);
          },
          icon: Icon(Icons.add),
        )
      ]),
      drawer: SideAppDrawer(),
      //we will create a future builder that will help us
      //build or load according to what return from the future method
      body: FutureBuilder(
        future: _refreshAndFetchData(context),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () => _refreshAndFetchData(context),
                child: Consumer<ProductsProvider>(
                  builder: (ctx, productsData, _) => Padding(
                    padding: EdgeInsets.all(8),
                    child: ListView.builder(
                      itemCount: productsData.loadedItems.length,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            UserProductItem(
                                productsData.loadedItems[index].title!,
                                productsData.loadedItems[index].imageUrl!,
                                productsData.loadedItems[index].description!,
                                productsData.loadedItems[index].id!),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
