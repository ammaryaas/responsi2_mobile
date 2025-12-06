class ApiUrl {
  static const String baseUrl = 'http://127.0.0.1:8000/api';
  static const String registration = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listProduct = baseUrl + '/product';
  static const String createProduct = baseUrl + '/product';
  static String updateProduct(int id) {
    return baseUrl + '/product/' + id.toString();
  }

  static String showProduct(int id) {
    return baseUrl + '/product/' + id.toString();
  }

  static String deleteProduct(int id) {
    return baseUrl + '/product/' + id.toString();
  }
}
