import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';
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
  var _isInit = true;
  var _isLoad = false;
  @override
  void initState() {
    // ! SEMUA OF GK BAKAL WORK DI INITSTATE kalau pake listen: false 'cuma bisa di provider' baru bisa pake future / async await
    // ! SEMUA OF GK BAKAL WORK DI INITSTATE
    // Provider.of<Products>(context).fetchProduct();
    // ! SOLVENYA PAKE FUTURE.DELAYED(DURATION.ZERO)
    super.initState();
  }

  // ! AFTER INITSTATE DAN SEBELUM RENDER
  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoad = true;
      Provider.of<Products>(context).fetchProduct().then((_) {
        setState(() {
          _isLoad = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  } //! dont change into async await for each state like this one and initstate

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
      drawer: const AppDrawer(),
      body: _isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showFav: _showOnlyFavourites),
    );
    return scaffold;
  }
}
