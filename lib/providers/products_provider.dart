import 'package:flutter/material.dart';
import 'product.dart';

//A class that can be extended or mixed in that provides
//a change notification API using [VoidCallback] for notifications.
//It is O(1) for adding listeners and O(N) for removing listeners
//and dispatching notifications (where N is the number of listeners).
class ProductsProvider with ChangeNotifier {
  // list not final because it will be changeable
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Taasa',
      description: 'Prepare any meal you want.',
      price: 80.50,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/31jLiaqeNdL.__AC_SY300_SX300_QL70_ML2_.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Taarha Safraa',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 30.50,
      imageUrl: 'https://m.media-amazon.com/images/I/31Ffs5O9sQL._AC_.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Red Te-Shirt ',
      description: 'A red shirt - it is pretty red!',
      price: 40.50,
      imageUrl:
          'https://m.media-amazon.com/images/I/71b+8uvjlcL._AC_SX679_.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Pantaloon',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://m.media-amazon.com/images/I/91gNRIwB-jL._AC_SY445_.jpg',
    ),
  ];

  //This VAr and The check down Will Be for
  // return a list with  only favorites
  /**************************************************************** */
  // var _showFavorites = false;
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

  //add new product
  void addProduct(Product product) {
    final newProduct = Product(
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      id: DateTime.now().toString(),
    );
    _items.add(newProduct);
    // _items.insert(0, newProduct); // at the start of the list
    notifyListeners();
  }

  /// update Product
  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  /// delete Product

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
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
