import 'package:flutter/material.dart';
// import '../models/product.dart';
import '../widgets/product_grid_widget.dart';

class ProductOverviewScreen extends StatelessWidget {
  // final List<Product> loadedProducts ;
  @override
  Widget build(BuildContext context) {
    /******************************************************************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        centerTitle: true,
      ),
      body: ProductWidget(),
    );
  }
}
