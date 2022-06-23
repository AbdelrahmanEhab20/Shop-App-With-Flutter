// we will implement rhe abstract class of Exceptions
///-------------------------------------
// MEaning we will implement
// it's function and use it
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
