import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'categorries.dart';
import 'constants.dart';
import 'item_card.dart';
import 'models/ProductMenu.dart';
import 'detail.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final database = FirebaseDatabase.instance.reference();
  List<ProductMenu> product = List();
  @override
  void initState() {
    super.initState();
    readdata();
  }

  Future<void> readdata() async {
    // FirebaseDatabase firebaseDatabase= FirebaseDatabase.instance;
    // DatabaseReference databaseReference = firebaseDatabase.child('Product');
    //  await databaseReference.once().then((DataSnapshot snapshot) {
    database
        .child('Product')
        // .child('ไข่เจียวกิมจิ')
        .orderByChild('id')
        .once()
        .then((DataSnapshot snapshot) {
      Map values = snapshot.value;
      values.forEach((key, values) {
        ProductMenu productMenu = ProductMenu.formMap(values);
        setState(() {
          product.add(productMenu);
          // print(values);
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Categories(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
            child: GridView.builder(
                itemCount: product.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                      productMenu: product[index],
                      press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              product: product[index],
                            ),
                          )),
                    )),
          ),
        ),
      ],
    );
  }
}
