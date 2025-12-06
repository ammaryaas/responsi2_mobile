class Login {
  int? code;
  bool? success;
  String? token;
  int? userID;
  String? userEmail;
  Login({this.code, this.success, this.token, this.userID, this.userEmail});
  factory Login.fromJson(Map<String, dynamic> obj) {
    if (obj['code'] == 200) {
      return Login(
        code: obj['code'],
        success: obj['status'],
        token: obj['data']['token'],
        userID: obj['data']['user']['id'],

        userEmail: obj['data']['user']['email'],
      );
    } else {
      return Login(code: obj['code'], success: obj['status']);
    }
  }
}
