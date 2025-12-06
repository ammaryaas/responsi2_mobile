class Registration {
  int? code;
  bool? status;
  String? data;
  Registration({this.code, this.status, this.data});
  factory Registration.fromJson(Map<String, dynamic> obj) {
    return Registration(
      code: obj['code'],
      status: obj['status'],
      data: obj['data'],
    );
  }
}
