import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'product.dart';
import '../models/http_exceptions.dart';

//A class that can be extended or mixed in that provides
//a change notification API using [VoidCallback] for notifications.
//It is O(1) for adding listeners and O(N) for removing listeners
//and dispatching notifications (where N is the number of listeners).
class ProductsProvider with ChangeNotifier {
  // list not final because it will be changeable
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
    //   Product(
    //     id: 'p5',
    //     title: 'Taasa',
    //     description: 'Prepare any meal you want.',
    //     price: 80.50,
    //     imageUrl:
    //         'https://images-na.ssl-images-amazon.com/images/I/31jLiaqeNdL.__AC_SY300_SX300_QL70_ML2_.jpg',
    //   ),
    //   Product(
    //     id: 'p6',
    //     title: 'Taarha Safraa',
    //     description: 'Warm and cozy - exactly what you need for the winter.',
    //     price: 30.50,
    //     imageUrl: 'https://m.media-amazon.com/images/I/31Ffs5O9sQL._AC_.jpg',
    //   ),
    //   Product(
    //     id: 'p7',
    //     title: 'Red Te-Shirt ',
    //     description: 'A red shirt - it is pretty red!',
    //     price: 40.50,
    //     imageUrl:
    //         'https://m.media-amazon.com/images/I/71b+8uvjlcL._AC_SX679_.jpg',
    //   ),
    //   Product(
    //     id: 'p8',
    //     title: 'Pantaloon',
    //     description: 'A nice pair of trousers.',
    //     price: 59.99,
    //     imageUrl:
    //         'https://m.media-amazon.com/images/I/91gNRIwB-jL._AC_SY445_.jpg',
    //   ),
  ];

  //This VAr and The check down Will Be for
  // return a list with  only favorites
  /**************************************************************** */
  //var _showFavorites = false;
  /**************************************************************** */
  //We will Pass This List With A getter return the original
  //  one to make it un Changeable at the original on it's references
  //because when the products changed function will be called to call the widgets interested in the products data
  List<Product> get loadedItems {
    // if (_showFavorites) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  /* Favorites List After Canceling it's methods  */
  List<Product> get favoritesItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  //Find By ID Products
  Product findByID(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  /// Fetching data for our products With API -------
  Future<void> fetchAndSetProducts() async {
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com', '/products.json');
    //calling Get Method
    // Store The data back From the API
    try {
      final productsRespons = await http.get(urlCallServer);
      final ExtractedData =
          json.decode(productsRespons.body) as Map<String, dynamic>;
      if (ExtractedData.isEmpty) {
        return;
      }
      final List<Product> loadedProducts = [];
      ExtractedData.forEach((prodID, prodData) {
        loadedProducts.add(Product(
          id: prodID,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _items = loadedProducts;
      notifyListeners(); // to watch the changes and tell all the widgets that interested here
    } catch (error) {
      throw error;
    }
  }

  //add new product
  Future<void> addProduct(Product product) async {
    // async and await instead of then and catch ------->
    //--------------------------------------------------
    /* Dealing with http and make requests */
    //----------------------------------------------
    // new version of writing the link of server in flutter
    //(1)make a connection to the server --> FireBase .....
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com', '/products.json');
    //-------------------------------------------------
    try {
      //(2) send request ---> post
      final response = await http.post(urlCallServer,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite,
          }));

      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        // get automatic id from db
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  /// update Product
  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      //(1)make a connection to the server --> FireBase .....
      // here to target the id after calling the api with this link
      //Id ---> id.json .........
      final urlCallServer = Uri.https(
          'flutterproject-6bd3e-default-rtdb.firebaseio.com',
          '/products/${id}.json');
      await http.patch(urlCallServer,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  /// delete Product

  Future<void> deleteProduct(String id) async {
    //(1)make a connection to the server --> FireBase .....
    final urlCallServer = Uri.https(
        'flutterproject-6bd3e-default-rtdb.firebaseio.com',
        '/products/${id}.json');
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    Product? existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(urlCallServer);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }

  // void addProduct() {
  //   // loadedItems.add(value);
  //   // To help the widgets and to that there something new happened and changed
  //   notifyListeners();
  // }
  //Show Favorites Method To show only Favs
  // void showFavoritesOnly() {
  //   _showFavorites = true;
  //call notify listener to rebuilt according to changes
  //   notifyListeners();
  // }

  //Show All Products Method To show All items
  // void showAllProducts() {
  //   _showFavorites = false;
  //call notify listener to rebuilt according to changes
  //   notifyListeners();
  // }
}
