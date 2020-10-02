import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungmoopa/utility/normal_dialog.dart';
import 'package:ungmoopa/widget/main_sos.dart';
import 'package:ungmoopa/widget/main_user.dart';
import 'package:ungmoopa/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  Future<Null> checkLogin() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        if (event != null) {
          await FirebaseFirestore.instance
              .collection('Type')
              .doc(event.uid)
              .snapshots()
              .listen((event) {
            String type = event.data()['Type'];
            print('type = $type');
            routeToService(type);
          });
        }
      });
    });
  }

  void routeToService(String type) {
    switch (type) {
      case 'User':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainUser(),
            ),
            (route) => false);
        break;
      case 'SOS':
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainSOS(),
            ),
            (route) => false);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Colors.orange,
            ],
            radius: 1,
            center: Alignment(0, -0.3),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildLogo(),
                    buildText(),
                    buildUser(),
                    buildPassword(),
                    buildContainer()
                  ],
                ),
              ),
            ),
            buildNewRegister()
          ],
        ),
      ),
    );
  }

  Column buildNewRegister() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  )),
              child: Text(
                'New Register',
                style: TextStyle(
                  color: Colors.pink,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Container buildContainer() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      child: RaisedButton(
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            checkAuthen();
          }
        },
        child: Text('Login'),
      ),
    );
  }

  Future<Null> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user, password: password)
          .then((value) async {
        String uid = value.user.uid;
        await FirebaseFirestore.instance
            .collection('Type')
            .doc(uid)
            .snapshots()
            .listen((event) {
          String type = event.data()['Type'];
          routeToService(type);
        });
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 250,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'User :',
          suffixIcon: Icon(Icons.account_circle),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      width: 250,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Password :',
          suffixIcon: Icon(Icons.remove_red_eye),
        ),
      ),
    );
  }

  Text buildText() => Text(
        'อึ่ง หมูป่า',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.brown.shade800,
        ),
      );

  Container buildLogo() {
    return Container(
      width: 120,
      child: Image.asset('images/logo.png'),
    );
  }
}
