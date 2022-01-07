import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/cart.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favourites, all }

class ProductsOverview extends StatefulWidget {
  const ProductsOverview({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsOverview> createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('My Shop App'),
        actions: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch as Widget,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  child: Text('Only Favourite'),
                  value: FilterOptions.favourites,
                ),
                const PopupMenuItem(
                  child: Text('Show All'),
                  value: FilterOptions.all,
                )
              ];
            },
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favourites) {
                  _showOnlyFavourites = true;
                } else {
                  _showOnlyFavourites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductsGrid(showFav: _showOnlyFavourites),
    );
    return scaffold;
  }
}
