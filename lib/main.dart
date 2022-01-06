import 'package:flutter/material.dart';

import './screens/products_overview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shopp App Flutter',
        theme: ThemeData(
            primarySwatch: Colors.brown,
            //! ACCENT COLOR DEPECRATED USING COLOR SCHEME
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
                .copyWith(secondary: Colors.lime[600]),
            fontFamily: 'Lato'),
        home: ProductsOverview());
  }
}
