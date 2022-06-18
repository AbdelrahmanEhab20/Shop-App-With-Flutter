import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid_widget.dart';
import '../screens/cart_screen.dart';
import '../widgets/side_App_drawer.dart';

// import '../providers/products_provider.dart';
// import 'package:provider/provider.dart';
// import '../models/product.dart';
enum FilterOptions { Favorites, All }

//Cancel Working with Providers here
// and turn it into StateFul Widget to manage it's state
class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  // final List<Product> loadedProducts ;
  // Var for handle Favorites
  var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    //set false , we are not interested in data when it's changed
    // we just need to have access on container to call the new methods
    // final productsItems = Provider.of<ProductsProvider>(context, listen: false);
    /******************************************************************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            //won't rebuilt when value changes
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
        centerTitle: true,
      ),
      drawer: SideAppDrawer(),
      //Will Forward this var to products
      body: ProductWidget(_showOnlyFavorites),
    );
  }
}
