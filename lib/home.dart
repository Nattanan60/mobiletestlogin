import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/body.dart';

class Myhome extends StatefulWidget {
  // ignore: deprecated_member_use

  @override
  _MyhomeState createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.red,
      elevation: 3,
      centerTitle: true,
      title: Text('หน้าแรก',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
