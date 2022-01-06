import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String id;
  final String title;

  const ProductItem(
      {Key? key, required this.id, required this.imageUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! FORCES CHILD WIDGET INTO CERTAIN SHAPE
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            // ! WITHOUT PUSHEDNAME
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (ctx) => ProductDetail(title: title)));
            Navigator.of(context)
                .pushNamed(ProductDetail.routeName, arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
