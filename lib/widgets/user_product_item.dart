import 'package:flutter/material.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:provider/provider.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  UserProductItem(this.title, this.imageUrl, this.description, this.id);
  @override
  Widget build(BuildContext context) {
    final MyScaffoldHandle = ScaffoldMessenger.of(context);
    return SingleChildScrollView(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        //backgroundImage instead of widget take a image provider
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        // two options for each product Delete or Edit
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(
              onPressed: (() {
                Navigator.pushNamed(context, EditUserProductScreen.routeName,
                    arguments: id);
              }),
              icon: Icon(Icons.edit_sharp),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: (() async {
                try {
                  await Provider.of<ProductsProvider>(context, listen: false)
                      .deleteProduct(id);
                } catch (error) {
                  MyScaffoldHandle.showSnackBar(SnackBar(
                    content: Text('Deleting Failed!!!'),
                  ));
                }
              }),
              icon: Icon(Icons.delete_forever_sharp),
              color: Color.fromARGB(255, 244, 21, 5),
            )
          ]),
        ),
      ),
    );
  }
}
