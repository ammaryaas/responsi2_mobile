import 'dart:convert';
import 'package:supermarketkita/helpers/api.dart';
import 'package:supermarketkita/helpers/api_url.dart';
import 'package:supermarketkita/model/login.dart';

class LoginBloc {
  static Future<Login> login({
    String? email, 
    String? password
  }) async {
    String apiUrl = ApiUrl.login;
    var body = { "email": email, "password": password };
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
