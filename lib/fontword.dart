import 'package:flutter/material.dart';
import 'models/ProductMenu.dart';

class Salution extends StatelessWidget {
  const Salution({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductMenu product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "วิธีทำ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(),
            ],
          ),
        ),
      ],
    );
  }
}
