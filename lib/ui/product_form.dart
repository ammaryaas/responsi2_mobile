import 'package:flutter/material.dart';
import 'package:supermarketkita/bloc/product_bloc.dart';
import 'package:supermarketkita/model/product.dart';
import 'package:supermarketkita/ui/product_page.dart';
import 'package:supermarketkita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProductForm extends StatefulWidget {
  Product? product;
  ProductForm({Key? key, this.product}) : super(key: key);
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH PRODUCT";
  String tombolSubmit = "SIMPAN";
  final _kodeProductTextboxController = TextEditingController();
  final _namaProductTextboxController = TextEditingController();
  final _hargaProductTextboxController = TextEditingController();
  final _amountProductTextboxController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.product != null) {
      setState(() {
        judul = "UBAH PRODUCT AMMAR";
        tombolSubmit = "UBAH";
        _kodeProductTextboxController.text = widget.product!.kodeProduct!;
        _namaProductTextboxController.text = widget.product!.namaProduct!;
        _hargaProductTextboxController.text = widget.product!.hargaProduct
            .toString();
        _amountProductTextboxController.text = widget.product!.amount.toString();
      });
    } else {
      judul = "TAMBAH PRODUCT AMMAR";

      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _kodeProductTextField(),
                _namaProductTextField(),
                _hargaProductTextField(),
                _amountProductTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Membuat Textbox Kode Product
  Widget _kodeProductTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Kode Product"),
      keyboardType: TextInputType.text,
      controller: _kodeProductTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kode Product harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Nama Product
  Widget _namaProductTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Nama Product"),
      keyboardType: TextInputType.text,
      controller: _namaProductTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Product harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Harga Product
  Widget _hargaProductTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Harga"),
      keyboardType: TextInputType.number,
      controller: _hargaProductTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Harga harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Textbox Amount Product
  Widget _amountProductTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Jumlah"),
      keyboardType: TextInputType.number,
      controller: _amountProductTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Jumlah harus diisi";
        }
        return null;
      },
    );
  }

  //Membuat Tombol Simpan/Ubah
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            if (widget.product != null) {
              //kondisi update product
              ubah();
            } else {
              //kondisi tambah product
              simpan();
            }
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Product createProduct = Product(id: null);
    createProduct.kodeProduct = _kodeProductTextboxController.text;
    createProduct.namaProduct = _namaProductTextboxController.text;
    createProduct.hargaProduct = int.parse(_hargaProductTextboxController.text);
    createProduct.amount = int.parse(_amountProductTextboxController.text);
    ProductBloc.addProduct(product: createProduct).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const ProductPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Product updateProduct = Product(id: widget.product!.id!);
    updateProduct.kodeProduct = _kodeProductTextboxController.text;
    updateProduct.namaProduct = _namaProductTextboxController.text;
    updateProduct.hargaProduct = int.parse(_hargaProductTextboxController.text);
    updateProduct.amount = int.parse(_amountProductTextboxController.text);
    ProductBloc.updateProduct(product: updateProduct).then(
      (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const ProductPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Permintaan ubah data gagal, silahkan coba lagi",
          ),
        );
      },
    );
    setState(() {
      _isLoading = false;
    });
  }
}
