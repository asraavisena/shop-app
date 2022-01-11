import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/orders.dart' as ordersscreen;
import './providers/orders.dart';
import './screens/cart.dart';

import './providers/cart.dart';
import './screens/product_detail.dart';
import './providers/products.dart';
import './screens/products_overview.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';
import './screens/add_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ! REGISTER PROVIDER
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (ctx) =>
                Products()), //! ONLY REBUILD WHEN THE WIDGET LISTENED
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProvider(create: (ctx) => Orders())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopp App Flutter',
        theme: ThemeData(
            primarySwatch: Colors.lime,
            //! ACCENT COLOR DEPECRATED USING COLOR SCHEME
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lime)
                .copyWith(secondary: Colors.brown[300]),
            fontFamily: 'Lato'),
        home: const ProductsOverview(),
        routes: {
          ProductDetail.routeName: (ctx) => const ProductDetail(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          ordersscreen.Orders.routeName: (ctx) => const ordersscreen.Orders(),
          UserProducts.routeName: (ctx) => const UserProducts(),
          EditProduct.routeName: (ctx) => const EditProduct(),
          AddProduct.routeName: (ctx) => const AddProduct()
        },
      ),
    );
  }
}
