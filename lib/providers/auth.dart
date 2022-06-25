import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myshop/models/http_exceptions.dart';

//Api Key --- > AIzaSyBd8k0YY_0P2KVFhzGofcJBMaum2W41NFY
//************ SignUp Link
// https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBd8k0YY_0P2KVFhzGofcJBMaum2W41NFY
class AuthProvider with ChangeNotifier {
  //Wil Manage the app feature with token --> **
  /* token*/ String? _token;
  /* _expiryDateToken */ DateTime? _expiryDateToken;
  // To Control the logic based on the time of expiration
  //---> security mechanism that it will end after some time after one hour --> inside firebase
  //--------------------------------------------------------------------------------------------
  // user id when he logged_in
  /* _userId */ String? _userId;

//Data That Ensure User Is Auth or Not To control Screens
  bool get isAuth {
    return _token != null;
  }

  //Set The Token and Check IT
  String? get token {
    if (_expiryDateToken != null &&
        _expiryDateToken!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  //Getter For pass The UserID To the place we want
  String? get userID {
    return _userId;
  }

  //Method Of Signing-Up ---- >>
  Future<void> signUp(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBd8k0YY_0P2KVFhzGofcJBMaum2W41NFY');

    try {
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
      _userId = responseData['localId'];
      _expiryDateToken = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //Sign in
  //https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBd8k0YY_0P2KVFhzGofcJBMaum2W41NFY
  //Method Of Signing-Up ---- >>
  Future<void> signIn(String email, String password) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBd8k0YY_0P2KVFhzGofcJBMaum2W41NFY');
    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDateToken = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
