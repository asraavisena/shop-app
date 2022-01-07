import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context); //!
    final products = productsData.items;
    return GridView.builder(
      // ! HOW MANY COLUMN WILL BE SHOWED
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (ctx, index) {
        // ! REGISTERED NESTED PROVIDER
        return ChangeNotifierProvider(
          create: (c) => products[index],
          child: const ProductItem(),
        );
      },
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
    );
  }
}
