import 'package:flutter/material.dart';
import 'package:myshop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import '../helpers/custom_page_route.dart';
import '../providers/auth.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

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
              Navigator.push(
                  context, SlideRightRoute(page: ProductOverviewScreen()));
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
              Navigator.push(context, ScaleRoute(page: OrdersScreen()));
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
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Navigator.push(
                  context, RotationRoute(page: UserProductsScreen()));
            }),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app_sharp, color: Colors.black54),
            title: Text(
              'Log-Out',
              style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            onTap: (() {
              //To Stop Errors And Not Leaving The Drawer Opened
              //call pop Method Navigator
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              //Calling From the provider to log out
              Provider.of<AuthProvider>(context, listen: false).logOut();
            }),
          ),
        ],
      ),
    );
  }
}
