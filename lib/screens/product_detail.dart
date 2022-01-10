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
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                height: 300,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${loadedProduct.price}',
                style: const TextStyle(color: Colors.grey, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              )
            ],
          ),
        ));
  }
}
