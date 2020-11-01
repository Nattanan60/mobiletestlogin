import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

import 'package:firebase_database/firebase_database.dart';

import 'login_screen.dart';

// ignore: must_be_immutable
class Register extends StatefulWidget {
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance.reference();
  String username, password, mail, name;
  Widget get email {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Container(
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your Username',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) => username = value.trim()),
          ),
        ),
      ],
    );
  }

  Widget _email() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'E-mail',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Container(
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your E-mail',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) => mail = value.trim()),
          ),
        ),
      ],
    );
  }

  Widget _name() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: Container(
            child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.account_box,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your Name',
                  hintStyle: kHintTextStyle,
                ),
                onChanged: (value) => name = value.trim()),
          ),
        ),
      ],
    );
  }

  Widget _password() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter your Password',
                hintStyle: kHintTextStyle,
              ),
              onChanged: (value) => password = value.trim()),
        ),
      ],
    );
  }

  Widget loginBt() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: Center(
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            if (username == null ||
                username.isEmpty ||
                password == null ||
                password.isEmpty ||
                name == null ||
                name.isEmpty ||
                mail == null ||
                mail.isEmpty) {
              String title = 'กรุณากรอกข้อมูล';
              myAlert(title);
            } else {
              var root = database.child("user");
              root.child(username).once().then((DataSnapshot snapshot) {
                if ('${snapshot.value}' == 'null') {
                  check();
                } else {
                  String title = 'มีข้อมูลแล้ว';
                  myAlert(title);
                }
              });
            }
          },
          padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.black,
          child: Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

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

  void myAlert(String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showTitle(title),
            content: Text(title),
            actions: <Widget>[okBtn()],
          );
        });
  }

  Future<Null> check() async {
    var root = database.child("user");
    root.child(username).set({
      'name': name,
      'password': password,
      'email': mail,
    });
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => LoginScreen(),
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.red,
                      Colors.red,
                      Colors.redAccent,
                      Colors.white,
                    ],
                    stops: [0.2, 0.5, 0.7, 1],
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'FOOD CLEAN',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _name(),
                        SizedBox(height: 30.0),
                        email,
                        SizedBox(
                          height: 30.0,
                        ),
                        _email(),
                        SizedBox(height: 30.0),
                        _password(),
                        loginBt(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
