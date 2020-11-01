import 'package:flutter/material.dart';

import 'models/ProductMenu.dart';
import 'constants.dart';

class ItemCard extends StatelessWidget {
  final ProductMenu productMenu;
  final Function press;
  const ItemCard({
    Key key,
    this.productMenu,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Hero(
                tag: "${productMenu.id}",
                child: Image.network(productMenu.image),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(

                // products is out demo list
                productMenu.title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
        ],
      ),
    );
  }
}
