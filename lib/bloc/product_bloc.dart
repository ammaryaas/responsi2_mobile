import 'dart:convert';
import 'package:supermarketkita/helpers/api.dart';
import 'package:supermarketkita/helpers/api_url.dart';
import 'package:supermarketkita/model/product.dart';

class ProductBloc {
  static Future<List<Product>> getProducts() async {
    try {
      String apiUrl = ApiUrl.listProduct;
      print('Fetching products from: $apiUrl');
      var response = await Api().get(apiUrl);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      var jsonObj = json.decode(response.body);
      List<dynamic> listProduct = (jsonObj as Map<String, dynamic>)['data'];
      List<Product> product = [];
      for (int i = 0; i < listProduct.length; i++) {
        product.add(Product.fromJson(listProduct[i]));
      }
      return product;
    } catch (e) {
      print('Error in getProducts: $e');
      rethrow;
    }
  }

  static Future addProduct({Product? product}) async {
    String apiUrl = ApiUrl.createProduct;
    var body = {
      "product_code": product!.kodeProduct,
      "product_name": product.namaProduct,
      "price": product.hargaProduct.toString(),
      "amount": product.amount.toString(),
    };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future updateProduct({required Product product}) async {
    String apiUrl = ApiUrl.updateProduct(int.parse(product.id!));
    print(apiUrl);
    var body = {
      "product_code": product.kodeProduct,
      "product_name": product.namaProduct,
      "price": product.hargaProduct.toString(),
      "amount": product.amount.toString(),
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteProduct({int? id}) async {
    try {
      String apiUrl = ApiUrl.deleteProduct(id!);
      var response = await Api().delete(apiUrl);      
      var jsonObj = json.decode(response.body);
      bool isSuccess = jsonObj['success'] ?? jsonObj['data'] ?? false;
      return isSuccess;
    } catch (e) {
      rethrow;
    }
  }
}
