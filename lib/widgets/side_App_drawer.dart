import 'package:flutter/material.dart';
import 'package:myshop/screens/orders_screen.dart';
import 'package:myshop/screens/user_products_screen.dart';

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
            leading: Icon(Icons.shop, color: Colors.black54),
            title: Text(
              'Shop',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            onTap: (() {
              Navigator.of(context).pushReplacementNamed('/');
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment_sharp, color: Colors.black54),
            title: Text(
              'Orders',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.manage_accounts_sharp, color: Colors.black54),
            title: Text(
              'Manage Products',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            onTap: (() {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            }),
          ),
        ],
      ),
    );
  }
}
