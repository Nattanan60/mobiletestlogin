import 'package:flutter/material.dart';
import 'models/ProductMenu.dart';

class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductMenu product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(170, 0, 0, 0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 0.1),
          Container(
              width: 220,
              height: 200,
              child: Expanded(
                child: Hero(
                  tag: "${product.id}",
                  child: Image.network(
                    product.image,
                    fit: BoxFit.fill,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
