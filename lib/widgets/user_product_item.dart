import 'package:flutter/material.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  UserProductItem(this.title, this.imageUrl, this.description);
  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, EditUserProductScreen.routeName);
              }),
              icon: Icon(Icons.edit_sharp),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: (() {}),
              icon: Icon(Icons.delete_forever_sharp),
              color: Color.fromARGB(255, 244, 21, 5),
            )
          ]),
        ),
      ),
    );
  }
}
