import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home_page.dart';

class EditProduct extends StatelessWidget {
  // EditProduct({super.key});
  final Map product;
  EditProduct({required this.product});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  Future updateProduct() async {
    final response = await http.put(
        Uri.parse(
            'http://10.0.2.2:8000/api/products/' + product['id'].toString()),
        body: {
          'name': _nameController.text,
          'description': _descController.text,
          'price': _priceController.text,
          'image_url': _urlController.text,
        });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController..text = product['name'],
                  decoration:
                      const InputDecoration(labelText: ' Nama Produk ;'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan Isi Nama Produk dulu";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _descController..text = product['description'],
                  decoration: const InputDecoration(labelText: ' Keterangan ;'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan Isi Keterangan dulu";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _priceController..text = product['price'],
                  decoration: const InputDecoration(labelText: ' Harga ;'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan Isi Harga Produk dulu";
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _urlController..text = product['image_url'],
                  decoration:
                      const InputDecoration(labelText: ' Link Gambar ;'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Silakan Isi Link Gambar Produk dulu";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateProduct().then((value) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data berhasil diubah'),
                          ),
                        );
                      });
                    }
                  },
                  child: const Text('Update'),
                )
              ],
            ),
          )
          // Text('Ini halaman tambah produk'),
          ),
    );
  }
}
