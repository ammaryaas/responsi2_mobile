import 'dart:convert';
import 'package:supermarketkita/helpers/api.dart';
import 'package:supermarketkita/helpers/api_url.dart';
import 'package:supermarketkita/model/registration.dart';

class RegistrationBloc {
  static Future<Registration> registration({
    String? name,
    String? email,
    String? password,
  }) async {
    String apiUrl = ApiUrl.registration;
    var body = {"name": name, "email": email, "password": password};
    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return Registration.fromJson(jsonObj);
  }
}
