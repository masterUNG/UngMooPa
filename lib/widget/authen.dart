import 'package:flutter/material.dart';
import 'package:ungmoopa/widget/register.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
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
        onPressed: null,
        child: Text('Login'),
      ),
    );
  }

  Container buildUser() {
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 16),
      width: 250,
      child: TextField(
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
