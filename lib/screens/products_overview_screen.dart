import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products_provider.dart';
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
  ///---------------------------------------------------------------------------------
  //============================================================================
  // fetching data from api *********
  //================================================================
  @override
  void initState() {
    // Best place to fetch data before the screen start to be built
    // http.get();
    // Provider.of<ProductsProvider>(context)
    //     .fetchAndSetProducts();  -------? >>>>> // will not work because it can't access the context run before build
    // first solution ---> wrap it with duration delayed future --> .then (fetch data) ----- not the best
    // second solution---->  didChangeDependencies --> run after the widget built it's context
    super.initState();
  }

  //loading var for loader
  var _isLoading = false;
  var _isInit = true;
  // Best Solution to fetch data for now and handle it with true - false var to stop it's run many times
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      /// till the data fetched
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context)
          .fetchAndSetProducts()
          .then((value) =>
              // here after loading end set again to false
              setState(() {
                _isLoading = false;
              }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductWidget(_showOnlyFavorites),
    );
  }
}
