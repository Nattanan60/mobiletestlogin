import 'package:flutter/material.dart';

import 'models/ProductMenu.dart';

class Description extends StatelessWidget {
  const Description({
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
          // height: 100,
          child: Text(
            product.conship,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
