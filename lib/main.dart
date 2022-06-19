import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../providers/cart_provider.dart';
import '../screens/product_details_screen.dart';
import '../screens/products_overview_screen.dart';
import '../providers/products_provider.dart';
import '../providers/orders_provider.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';
import '../screens/edit_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //wrap our widget with the most common provider
    //that will be use to open the communication with the provider
    //help to listen to child widgets of it
    //and when the class changed only children here will listen to those changes
    /******************************************************************************* */
    return MultiProvider(
      providers: [
        // Provider---> ProductClass Provider
        ChangeNotifierProvider(
            // crate inside it's builder method with context help
            // will help to return a new instance of our provider class
            create: (ctx) => ProductsProvider()),
        // Provider---> CartClass Provider
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
        // Provider---> CartClass Provider
        ChangeNotifierProvider(
          create: (ctx) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
              primarySwatch: Colors.teal,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: ProductOverviewScreen(),
          routes: {
            ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditUserProductScreen.routeName: (ctx) => EditUserProductScreen(),
          }),
    );
  }
}
