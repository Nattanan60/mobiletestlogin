import 'package:flutter/material.dart';
import 'package:testlogin/index.dart';
import 'models/ProductMenu.dart';

class DetailsScreen extends StatelessWidget {
  final ProductMenu product;

  const DetailsScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Colors.black,
      appBar: buildAppBar(context),
      body: Index(product: product),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(product.title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: Colors.black26,
      elevation: 0,
    );
  }
}
