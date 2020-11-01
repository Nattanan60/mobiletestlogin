import 'package:flutter/material.dart';
import 'package:testlogin/addmenu.dart';
import 'package:testlogin/home.dart';

import 'constants.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["เลือกดูสูตรอาหาร", "เพิ่มสูตรอาหาร"];
  // By default our first item will be selected
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCategory(index),
        ),
      ),
    );
  }

  Widget buildCategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        if (index == 0) {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => Myhome(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        } else {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => addmenu(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        }
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 5, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index ? kTextColor : kTextLightColor,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5), //top padding 5
              height: 5,
              width: 50,
              color: selectedIndex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
