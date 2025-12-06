class Product {
  String? id;
  String? kodeProduct;
  String? namaProduct;
  var hargaProduct;
  var amount;
  Product({this.id, this.kodeProduct, this.namaProduct, this.hargaProduct, this.amount});
  factory Product.fromJson(Map<String, dynamic> obj) {
    return Product(
      id: obj['id'].toString(),
      kodeProduct: obj['product_code'],
      namaProduct: obj['product_name'],
      hargaProduct: obj['price'],
      amount: obj['amount'],
    );
  }
}
