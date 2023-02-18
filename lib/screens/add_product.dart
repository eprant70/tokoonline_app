import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/home_page.dart';
import 'dart:convert';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  Future saveProduct() async {
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8000/api/products/'), body: {
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
        title: const Text('Tambah Produk'),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _nameController,
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
                  controller: _descController,
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
                  controller: _priceController,
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
                  controller: _urlController,
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
                      saveProduct().then((value) {
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
                  child: const Text('Simpan'),
                )
              ],
            ),
          )
          // Text('Ini halaman tambah produk'),
          ),
    );
  }
}
