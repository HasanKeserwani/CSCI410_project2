import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String _baseURL = 'hasankeserwani.000webhostapp.com';

class Product {
  int _pid;
  String _name;
  double _price;
  String _productImage; // New field for product image

  Product(this._pid, this._name, this._price, this._productImage);

  @override
  String toString() {
    return 'PID: $_pid\nName: $_name\nPrice: \$$_price';
  }
}

List<Product> _products = [];

void updateProducts(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'getProducts.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) {
        Product p = Product(
          int.parse(row['pid']),
          row['name'],
          double.parse(row['price']),
          row['product_image'], // Add product image field
        );
        _products.add(p);
      }
      update(true);
    }
  } catch (e) {
    update(false);
  }
}

void searchProduct(Function(String text) update, int pid) async {
  try {
    final url = Uri.https(_baseURL, 'searchProduct.php', {'pid': '$pid'});
    final response = await http.get(url).timeout(const Duration(seconds: 5));
    _products.clear();
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      var row = jsonResponse[pid-1];
      Product p = Product(
        int.parse(row['pid']),
        row['name'],
        double.parse(row['price']),
        row['product_image'],
      );
      _products.add(p);
      update(p.toString());
    }
  } catch (e) {
    update("can't load data");
  }
}

class ShowProducts extends StatelessWidget {
  const ShowProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1/1.3,
      ),
      itemCount: _products.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.memory(
                  base64.decode(_products[index]._productImage),
                  width: 100.0,
                  height: 100.0,
                ),

                Text(
                  _products[index]._name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),

                Text('\$${_products[index]._price}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
