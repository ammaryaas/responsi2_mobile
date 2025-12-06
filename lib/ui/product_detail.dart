import 'package:flutter/material.dart';
import 'package:supermarketkita/bloc/product_bloc.dart';
import 'package:supermarketkita/model/product.dart';
import 'package:supermarketkita/ui/product_form.dart';
import 'package:supermarketkita/ui/product_page.dart';
import 'package:supermarketkita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product? product;
  ProductDetail({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product Ammar'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.product!.kodeProduct}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.product!.namaProduct}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.product!.hargaProduct.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Jumlah : ${widget.product!.amount.toString()}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductForm(product: widget.product!),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () async {
            try {
              Navigator.pop(context); // Close dialog first
              
              final result = await ProductBloc.deleteProduct(
                id: int.parse(widget.product!.id!),
              );
              
              print('Delete result: $result');
              
              if (result) {
                // Add small delay to ensure delete completes
                await Future.delayed(const Duration(milliseconds: 500));
                
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const ProductPage()),
                    (route) => false,
                  );
                }
              } else {
                if (mounted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => const WarningDialog(
                      description: "Hapus gagal, silahkan coba lagi",
                    ),
                  );
                }
              }
            } catch (e) {
              print('Delete error: $e');
              if (mounted) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => WarningDialog(
                    description: "Hapus gagal: $e",
                  ),
                );
              }
            }
          },
        ),
        //tombol batal
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
