import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  const UserProductItem(
      {Key? key, required this.imageUrl, required this.title, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsDate = Provider.of<Products>(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        width: 100,
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProduct.routeName, arguments: id);
              },
              icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                productsDate.deleteProduct(id);
              },
              icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
