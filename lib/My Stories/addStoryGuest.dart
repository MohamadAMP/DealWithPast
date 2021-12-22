// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, unnecessary_this, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Backend/auth.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:interactive_map/Repos/media.dart';
import 'package:interactive_map/Homepages/mainPage.dart';
import 'package:interactive_map/Homepages/mainPageGuest.dart';
import 'package:interactive_map/Map/map.dart';

class AddStoryGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  UserRepo userRepo = UserRepo();
  Media media = Media();
  late var token;

  @override
  void initState() {
    super.initState();
  }

  Future<void> click() async {
    token = await userRepo.Authenticate("admin", "admin_1234");
    signInWithGoogle().then((user) async => {
          if (await userRepo.AuthenticateOther(
                  user!.email.toString().split('@')[0], user.uid) ==
              false)
            {
              //terms and conditions
              await userRepo.Login(user.uid, user.email.toString(),
                  user.email.toString().split('@')[0], token),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ))
            }
          else
            {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(),
                  ))
            },
        });
  }

  Widget loginButton() {
    // ignore: deprecated_member_use
    return OutlineButton(
        onPressed: this.click,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        splashColor: Colors.grey[600],
        borderSide: BorderSide(color: Colors.grey),
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'سجل مع Google',
                    style: TextStyle(color: Colors.grey, fontSize: 25),
                  ),
                ),
                Image(image: AssetImage('assets/google_logo.png'), height: 35),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF252422),
        child: Center(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 40),
            Center(
              child: Text(
                "لإضافة رواية عليك الدخول إلى حسابك الشخصي",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            SizedBox(height: 100),
            Container(child: loginButton()),
          ],
        ))));
  }
}
