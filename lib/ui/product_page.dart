import 'package:flutter/material.dart';
import 'package:supermarketkita/bloc/logout_bloc.dart';
import 'package:supermarketkita/bloc/product_bloc.dart';
import 'package:supermarketkita/model/product.dart';
import 'package:supermarketkita/ui/login_page.dart';
import 'package:supermarketkita/ui/product_detail.dart';
import 'package:supermarketkita/ui/product_form.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Product Ammar'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductForm()),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then(
                  (value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    ),
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProductBloc.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        (context as Element);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }
          
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Tidak ada data produk'));
          }
          
          return ListProduct(list: snapshot.data);
        },
      ),
    );
  }
}

class ListProduct extends StatelessWidget {
  final List? list;
  const ListProduct({Key? key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemProduct(product: list![i]);
      },
    );
  }
}

class ItemProduct extends StatelessWidget {
  final Product product;
  const ItemProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product),
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(product.namaProduct!),
          subtitle: Text(product.hargaProduct.toString()),
        ),
      ),
    );
  }
}
