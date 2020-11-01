import 'package:flutter/material.dart';

import 'models/ProductMenu.dart';

class Salo extends StatelessWidget {
  const Salo({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductMenu product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 300,
          // height: 120,
          child: Text(
            product.salotion,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
