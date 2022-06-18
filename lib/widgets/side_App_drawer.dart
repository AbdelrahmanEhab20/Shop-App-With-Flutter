import 'package:flutter/material.dart';
import 'package:myshop/screens/orders_screen.dart';

class SideAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Friend!'),
            automaticallyImplyLeading: false,
          ),
          //horizontal Line
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_sharp),
            title: Text('Orders'),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}
