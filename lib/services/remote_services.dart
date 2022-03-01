import 'package:flutter_mvc_api_getx_sqllite/models/product.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  static var client = http.Client();

  static Future<List<Welcome>?> fetchProducts() async {
    var response =
        await client.get(Uri.parse('https://fakestoreapi.com/products'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return welcomeFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
