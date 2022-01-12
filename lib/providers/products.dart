import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';

// ! LISTENER

class Products with ChangeNotifier {
  List<Product> _items = [
    //   Product(
    //     id: 'p1',
    //     title: 'Red Shirt',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 29.99,
    //     imageUrl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    //   ),
    //   Product(
    //     id: 'p2',
    //     title: 'Trousers',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    //   ),
    //   Product(
    //     id: 'p3',
    //     title: 'Yellow Scarf',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 19.99,
    //     imageUrl:
    //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    //   ),
    //   Product(
    //     id: 'p4',
    //     title: 'A Pan',
    //     description: 'Prepare any meal you want.',
    //     price: 49.99,
    //     imageUrl:
    //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    //   ),
  ];

  // var _showFavouriteOnly = false;

  List<Product> get items {
    // if (_showFavouriteOnly) {
    //   return _items.where((element) => element.isFavourite).toList();
    // }
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  // void showFavouriteOnly() {
  //   _showFavouriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavouriteOnly = false;
  //   notifyListeners();
  // }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchProduct() async {
    final url = Uri.https(
        'shop-app-flutter-db272-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/product.json');
    try {
      final response = await http.get(url);
      final extractData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProduct = [];
      extractData.forEach((prodId, prodData) {
        loadedProduct.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl']));
      });

      _items = loadedProduct;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProduct(Product product) async {
    // _items.add(value);
    final url = Uri.https(
        'shop-app-flutter-db272-default-rtdb.asia-southeast1.firebasedatabase.app',
        '/product.json');
    try {
      final response = await http.post(url,
          body: ({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl
          }));
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      // ! OR
      // _items.insert(0, newProduct); // at start of the list
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  // ! LIKE PROMISE / CALLBACK
  // Future<void> addProduct(Product product) {
  //   // _items.add(value);
  //   final url = Uri.https(
  //       'shop-app-flutter-db272-default-rtdb.asia-southeast1.firebasedatabase.app',
  //       '/product.json');
  //   return http
  //       .post(url,
  //           body: json.encode({
  //             'title': product.title,
  //             'description': product.description,
  //             'price': product.price,
  //             'imageUrl': product.imageUrl
  //           }))
  //       .then((res) {
  //     final newProduct = Product(
  //         id: DateTime.now().toString(),
  //         title: product.title,
  //         description: product.description,
  //         price: product.price,
  //         imageUrl: product.imageUrl);
  //     _items.add(newProduct);
  //     // ! OR
  //     // _items.insert(0, newProduct); // at start of the list
  //     notifyListeners();
  //   }).catchError((error) {
  //     throw error;
  //   });
  // }

  void updateProduct(String id, Product newProduct) {
    // _items.add(value);
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      // final newProduct = Product(
      //     id: DateTime.now().toString(),
      //     title: product.title,
      //     description: product.description,
      //     price: product.price,
      //     imageUrl: product.imageUrl);
      // _items.add(newProduct);
      // ! OR
      // _items.insert(0, newProduct); // at start of the list
      notifyListeners();
    } else {
      print('notfound');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
