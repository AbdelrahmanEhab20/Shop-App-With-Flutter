import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart';
import '../widgets/order_item.dart';
import '../widgets/side_App_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    //accessing the data and make instance of class ordersProvider
    final orderDetails = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
      ),
      drawer: SideAppDrawer(),
      body: ListView.builder(
        itemCount: orderDetails.ordersCopy.length,
        itemBuilder: (ctx, index) {
          return OrderItemWidget(orderDetails.ordersCopy[index]);
        },
      ),
    );
  }
}
