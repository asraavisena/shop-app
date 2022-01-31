import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/http_excception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }
  // ! BUAT REFACTORx
  // Future<void> _authenticate(String email, String password, String urlSegment) async {

  // }

  Future<void> singUp(String email, String password) async {
    try {
      final url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${dotenv.env['FIREBASE_API_KEY']}');
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localiId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> logIn(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${dotenv.env['FIREBASE_API_KEY']}');
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
    final responseData = json.decode(response.body);
    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
    _token = responseData['idToken'];
    _userId = responseData['localiId'];
    _expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    notifyListeners();
  }
}
