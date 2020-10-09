import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ungmoopa/utility/my_style.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  String name, email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readUserData();
  }

  Future<Null> readUserData() async {
    await Firebase.initializeApp().then((value) async {
      print('#####  initial Success  ####');
      await FirebaseAuth.instance.authStateChanges().listen((event) async {
        String uid = event.uid;
        print('uid = $uid');
        await FirebaseFirestore.instance
            .collection('User')
            .doc(uid)
            .snapshots()
            .listen((event) {
          setState(() {
            name = event.data()['Name'];
            email = event.data()['Email'];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main User'),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                buildUserAccountsDrawerHeader(),
                ListTile(
                  leading: Icon(Icons.live_help_outlined),
                  title: Text('ขอความช่วยเหลือ'),
                  subtitle: Text('คือเมนู ที่ คุณสามารถส่งพิกัด และ ข้อความ ขอความช่วยเหลือได้'),
                ),
              ],
            ),
            MyStyle().mySignOut(context),
          ],
        ),
      ),
    );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      currentAccountPicture: Image.asset('images/logo.png'),
      accountName: Text(
        name == null ? 'Name' : name,
        style: TextStyle(color: Colors.green[700]),
      ),
      accountEmail: Text(
        email == null ? 'Email' : email,
        style: TextStyle(color: Colors.green[700]),
      ),
    );
  }
}
