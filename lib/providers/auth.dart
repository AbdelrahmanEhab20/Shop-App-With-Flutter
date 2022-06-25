import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Timer? _authTimer;

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
      AutoLogOut();
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
      AutoLogOut();
      notifyListeners();
      //connect to the package and start to
      // make a channel between code and the device storage
      final preferencesCall = await SharedPreferences.getInstance();
      // and we will start to wite data into it and converted it by jsonEncode
      // map with userId , token ,expired time
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDateToken!.toIso8601String()
      });
      //wite to device our data
      preferencesCall.setString('UserData', userData);
    } catch (error) {
      throw error;
    }
  }

// Method That Will Try To Auto LOgin
// if it found the data from the device is valid
// bool --> true if data valid or false if not found token or expired
  Future<bool> tryAutoLogin() async {
    final preferencesCall = await SharedPreferences.getInstance();
    if (!preferencesCall.containsKey('UserData')) {
      return false;
    }
    final ExtractedUserData =
        json.decode(preferencesCall.getString('UserData').toString())
            as Map<String, dynamic>;
    final expiryDate = DateTime.parse(ExtractedUserData['expiryDate']);
    // check is After or i s Before DatTime.Now Valid if not then not valid
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    //then valid after check --> assign
    //the extracted valid data to original data
    _token = ExtractedUserData['token'];
    _userId = ExtractedUserData['userId'];
    _expiryDateToken = expiryDate;
    notifyListeners();
    AutoLogOut();
    return true;
  }

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expiryDateToken = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    //Clear the  data from prfrences shared
    // or clear (Remove Something Specific
    final preferencesCall = await SharedPreferences.getInstance();
    // preferencesCall.remove('UserData');
    preferencesCall.clear(); // all deleted
  }

  void AutoLogOut() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpireToken =
        _expiryDateToken!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpireToken), logOut);
  }
}
