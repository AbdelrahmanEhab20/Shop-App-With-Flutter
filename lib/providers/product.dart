import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

//Handle Favorite also with http
  Future<void> toggleFavoriteStatus(String authToken, String userID) async {
    final oldStatus = isFavorite;
    // Inverted the value to be the opposite of it's current value
    isFavorite = !isFavorite;
    //To listen on changes
    notifyListeners();
    //(1)make a connection to the server --> FireBase .....
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com',
        '/userFavorites/$userID/${id}.json',
        {'auth': '$authToken'});
    //http patch ---> only value of Favs
    try {
      final responseForError =
          await http.put(urlCallServer, body: json.encode(isFavorite));
      if (responseForError.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
