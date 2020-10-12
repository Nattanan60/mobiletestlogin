import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          centerTitle: true,
          title: Text("ทดสอบล็อคอิน", style: TextStyle(color: Colors.white)),
        ),
        body: Container(
            child: Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text("Hello", style: TextStyle(fontSize: 50)),
        ]))));
  }
}
