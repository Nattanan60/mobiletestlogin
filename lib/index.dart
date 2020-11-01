import 'package:flutter/material.dart';
import 'package:testlogin/models/ProductMenu.dart';
import 'package:testlogin/salu.dart';
import 'constants.dart';
import 'color_and_size.dart';
import 'description.dart';
import 'conter.dart';
import 'producttitle.dart';
import 'fontword.dart';

class Index extends StatelessWidget {
  final ProductMenu product;

  const Index({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.19),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: kDefaultPaddin,
                    right: kDefaultPaddin,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blueGrey,
                        Colors.blueGrey[200],
                        Colors.grey[200],
                        Colors.grey[50],
                      ],
                      stops: [0.2, 0.5, 0.6, 0.8],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ColorAndSize(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Description(product: product),
                      SizedBox(height: 50 / 2),
                      Salution(product: product),
                      SizedBox(height: kDefaultPaddin / 2),
                      Salo(product: product),
                      CounterWithFavBtn(),
                      SizedBox(height: kDefaultPaddin / 2),
                    ],
                  ),
                ),
                ProductTitleWithImage(product: product)
              ],
            ),
          )
        ],
      ),
    );
  }
}
