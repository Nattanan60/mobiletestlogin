import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testlogin/regis.dart';
import 'constants.dart';
import 'package:testlogin/home.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  // these 2 lines
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //
  runApp(LoginScreen());
}

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final database = FirebaseDatabase.instance.reference();
  String username, password;
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
      child: Row(
        children: <Widget>[
          RaisedButton(
            elevation: 5.0,
            onPressed: () {
              print(username);
              print(password);
              check();
            },
            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            color: Colors.white,
            child: Text(
              'LOGIN',
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
          RaisedButton(
            elevation: 5.0,
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => Register(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
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
        ],
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
    var data = database.child("user");
    print(data);
    await data.child(username).once().then((DataSnapshot snapshot) {
      print('Data ======>${snapshot.value}');
      if ('${snapshot.value}' == 'null') {
        print('user');
        String title = 'username ของท่านผิด';
        myAlert(title);
      } else if (password == '${snapshot.value['password']}') {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Myhome(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else {
        print('รหัสไม่ถูก');
        String title = 'รหัสไม่ถูกต้อง กรุณากรอกใหม่';
        myAlert(
          title,
        );
      }
    });
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
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        email,
                        SizedBox(
                          height: 30.0,
                        ),
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
