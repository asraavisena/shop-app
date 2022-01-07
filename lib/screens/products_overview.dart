import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';

class ProductsOverview extends StatelessWidget {
  const ProductsOverview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
      ),
      body: const ProductsGrid(),
    );
    return scaffold;
  }
}
