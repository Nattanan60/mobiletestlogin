import 'dart:io';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class addmenu extends StatefulWidget {
  @override
  _addmenuState createState() => _addmenuState();
}

class _addmenuState extends State<addmenu> {
  File file;
  String title, salution, conship, urlPicture;
  final database = FirebaseDatabase.instance.reference();
  @override
  Widget showTitle(String title) {
    return ListTile(
      leading:
          Icon(Icons.error_outline, size: 60.0, color: Colors.deepOrange[300]),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget okBtn() {
    return FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget btn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton.icon(
              color: Colors.blueAccent,
              onPressed: () {
                print('');
                if (file == null) {
                  String title = 'ไม่มีรูปภาพอาหาร';
                  String massage = 'กรุณาเพิ่มรูปภาพอาหาร';
                  myAlert(
                    title,
                    massage,
                  );
                } else if (title == null ||
                    title.isEmpty ||
                    salution == null ||
                    salution.isEmpty ||
                    conship == null ||
                    conship.isEmpty) {
                  String title = 'ไม่มีข้อมูลรายละเอียดอาหาร';
                  String massage = 'กรุณากรอกข้อมูลรายละเอียดอาหาร';
                  myAlert(
                    title,
                    massage,
                  );
                } else {
                  uptoStorage();
                }
              },
              icon: Icon(
                Icons.add_box,
                color: Colors.white,
                size: 30,
              ),
              label: Text(
                "เพิ่มสูตรวิธีการทำอาหาร",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        ),
      ],
    );
  }

  Future<void> uptoStorage() async {
    Random random = Random();
    int i = random.nextInt(10000);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    StorageReference storageReference =
        firebaseStorage.ref().child('Product/product$i.jpg');
    StorageUploadTask storageUploadTask = storageReference.putFile(file);
    urlPicture =
        await (await storageUploadTask.onComplete).ref.getDownloadURL();
    print('$urlPicture');
    insertFirebas();
  }

  Future<Null> insertFirebas() async {
    Random random = Random();
    int i = random.nextInt(10000);
    var root = database.child("Product");
    root.child(title).set({
      'tiltile': title,
      'conship': conship,
      'salotion': salution,
      'PathImage': urlPicture,
      'id': i,
    }).then((value) {
      MaterialPageRoute route = MaterialPageRoute(
        builder: (value) => Myhome(),
      );
      Navigator.of(context).pushAndRemoveUntil(route, (value) => false);
    });
  }

  void myAlert(String title, String massage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTitle(title),
            content: Text(massage),
            actions: <Widget>[okBtn()],
          );
        });
  }

  Widget conshipFrom() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (String stirng) {
            conship = stirng.trim();
          },
          decoration: InputDecoration(
              helperText: 'กรุณากรอกส่วนประกอบของท่าน',
              icon: Icon(Icons.description),
              labelText: 'ส่วนประกอบ'),
        ));
  }

  Widget salustionFrom() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (String stirng) {
            salution = stirng.trim();
          },
          decoration: InputDecoration(
              helperText: 'กรุณากรอกวิธีการทำของท่าน',
              icon: Icon(Icons.chat),
              labelText: 'วิธีการทำ'),
        ));
  }

  Widget titleFrom() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: TextField(
          onChanged: (String stirng) {
            title = stirng.trim();
          },
          decoration: InputDecoration(
              helperText: 'กรุณากรอกชื่ออาหารของท่าน',
              icon: Icon(Icons.fastfood),
              labelText: 'ชื่ออาหาร'),
        ));
  }

  Widget _camara() {
    return IconButton(
      icon: Icon(
        Icons.camera_enhance,
        size: 36.0,
        color: Colors.redAccent,
      ),
      onPressed: () {
        chooseImage(ImageSource.camera);
      },
    );
  }

  Future<void> chooseImage(ImageSource imageSource) async {
    try {
      // ignore: deprecated_member_use
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 800.0,
      );
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget gallery() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
        color: Colors.redAccent,
      ),
      onPressed: () {
        chooseImage(ImageSource.gallery);
      },
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          showBtn(),
          titleFrom(),
          conshipFrom(),
          salustionFrom(),
        ],
      ),
    );
  }

  Widget showBtn() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _camara(),
          gallery(),
        ]);
  }

  Widget showImage() {
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null
          ? Image.asset('assets/images/picture.png')
          : Image.file(file),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("หน้าเพิ่มสูตรและวิธีการทำอาหาร",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.navigate_before),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Myhome(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
            iconSize: 30,
          ),
        ),
        body: Container(
          child: Stack(
            children: <Widget>[
              showContent(),
              btn(),
            ],
          ),
        ));
  }
}
