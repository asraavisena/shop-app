import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/cart.dart';
import './screens/product_detail.dart';
import './providers/products.dart';
import './screens/products_overview.dart';

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
        routes: {ProductDetail.routeName: (ctx) => const ProductDetail()},
      ),
    );
  }
}
