import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './product_item.dart';
import '../providers/products.dart';

class ProductsGrid extends StatelessWidget {
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
        return ProductItem(
          id: products[index].id,
          imageUrl: products[index].imageUrl,
          title: products[index].title,
        );
      },
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
    );
  }
}
