import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  // final String imageUrl;
  // final String id;
  // final String title;

  const ProductItem({
    Key? key,
    //  required this.id,
    //   required this.imageUrl,
    //   required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ! NESTED
    final product = Provider.of<Product>(context, listen: false);
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
                .pushNamed(ProductDetail.routeName, arguments: product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
              // ! CONSUMER HANYA CHANGED SUBPART OF THE WIDGETS
              builder: (cx, product, child) {
            return IconButton(
              icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                product.toggleFavouriteStatus();
              },
            );
          }),
          title: Text(
            product.title,
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
