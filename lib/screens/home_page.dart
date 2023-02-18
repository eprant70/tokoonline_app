import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tokoonline/screens/add_product.dart';
import 'package:tokoonline/screens/edit_product.dart';
import 'package:tokoonline/screens/product_detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final String url = 'http://127.0.0.1:8000/api/products';
  final String url = 'http://10.0.2.2:8000/api/products';

  get fontWeight => null;

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    // print(json.decode(response.body));
    return json.decode(response.body);
  }

  Future deleteProduct(String productId) async {
    String url = 'http://10.0.2.2:8000/api/products/' + productId;
    var response = await http.delete(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    // getProducts();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        child: const Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
      appBar: AppBar(
        title: const Text('Toko Online'),
      ),
      body: FutureBuilder(
        future: getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data['data'].length,
              itemBuilder: (context, index) {
                return Container(
                    height: 180,
                    child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetail(
                                        product: snapshot.data['data'][index]),
                                  ),
                                );
                              },
                              child: Container(
                                height: 120,
                                width: 120,
                                padding: const EdgeInsets.all(20),
                                child: Image.network(
                                    snapshot.data['data'][index]['image_url']),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      snapshot.data['data'][index]['name'],
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(snapshot.data['data'][index]
                                        ['description']),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditProduct(
                                                      product: snapshot
                                                          .data['data'][index],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: const Icon(
                                                Icons.edit,
                                                size: 24.0,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                deleteProduct(snapshot
                                                        .data['data'][index]
                                                            ['id']
                                                        .toString())
                                                    .then((value) {
                                                  setState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                          'Data berhasil dihapus'),
                                                    ),
                                                  );
                                                });
                                              },
                                              child: const Icon(
                                                Icons.delete,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text('Rp. ' +
                                            snapshot.data['data'][index]
                                                ['price']),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )));
              },
            );
          } else {
            return const Text(
              'Data Error',
              style: TextStyle(fontSize: 40),
            );
          }
        },
      ),
    );
  }
}
