import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetail extends StatelessWidget {
  // final String title;
  const ProductDetail({
    Key? key,
    //  required this.title
  }) : super(key: key);

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    // ! EXTRACT ID
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context,
            listen:
                false //! IF PRODUCTS IS CHANGED THIS WIDGET IS NOT LISTENED OR REBUILD
            )
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Container(),
    );
  }
}
