import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
import './screens/auth.dart';
import './screens/splash_screen.dart';

Future<void> main() async {
  await dotenv.load();
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
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
              // ! CARA PERTAMA
              // create: (_) => Products(null, []),
              // update: (ctx, auth, prevProducts) => Products(
              //     auth.token as String,
              //     prevProducts == null
              //         ? []
              //         : prevProducts
              //             .items)
              // ! KARNA ADA ERROR DI NULL PAKE CARA KEDUA AJA
              create: (_) => Products(),
              update: (_, auth, products) => products!
                ..auth =
                    auth as Auth), //! ONLY REBUILD WHEN THE WIDGET LISTENED
          ChangeNotifierProvider(create: (ctx) => Cart()),
          // ! MENCOBA PAKE CARA PERTAMA
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(null, []),
            update: (ctx, auth, prevOrders) => Orders(auth.token as String,
                prevOrders == null ? [] : prevOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shopp App Flutter',
            theme: ThemeData(
                primarySwatch: Colors.lime,
                //! ACCENT COLOR DEPECRATED USING COLOR SCHEME
                colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lime)
                    .copyWith(secondary: Colors.brown[300]),
                fontFamily: 'Lato'),
            home: auth.isAuth
                ? const ProductsOverview()
                : FutureBuilder(
                    future: auth.tryAoutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductDetail.routeName: (ctx) => const ProductDetail(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              ordersscreen.Orders.routeName: (ctx) =>
                  const ordersscreen.Orders(),
              UserProducts.routeName: (ctx) => const UserProducts(),
              EditProduct.routeName: (ctx) => const EditProduct(),
              AddProduct.routeName: (ctx) => const AddProduct()
            },
          ),
        ));
  }
}
