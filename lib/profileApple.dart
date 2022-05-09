//Display Professional ProfileApple (Professional View)

// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_if_null_operators

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Homepages/mainPageGuest.dart';

import 'Backend/auth.dart';
import 'Repos/UserInfo.dart';
import 'Repos/UserRepo.dart';

// ignore: must_be_immutable
class ProfileApple extends StatefulWidget {
  @override
  _ProfileAppleState createState() => _ProfileAppleState();
}

class _ProfileAppleState extends State<ProfileApple> {
  User? user = FirebaseAuth.instance.currentUser;
  UserInfoRepo userRepo = UserInfoRepo();

  UserRepo userRepoTok = UserRepo();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = user!.displayName;
    var email = user!.email;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: <Widget>[
        Container(
          // color: Color(0xFF31302D),
          height: MediaQuery.of(context).size.height * 0.23,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellow.shade200,
              Colors.blue.shade300,
            ],
          )),
          child: Padding(
            padding: EdgeInsets.only(left: 30.0, top: 30.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                      child: Container(
                        height: 120,
                        width: 120,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                'https://dwpbucket2.s3.eu-central-1.amazonaws.com/wp-content/uploads/2022/01/27170402/profileApple.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.67,
          color: Color(0xFF252422),
          child: Column(
            children: [
              SizedBox(
                height: 45,
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 32.0, right: 32.0),
                  child: Center(
                      child: Text(
                    "معلومات",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        fontFamily: 'Baloo'),
                  ))),
              SizedBox(
                height: 25,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround/*  */,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        'الإسم :',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo'),
                      )),
                  SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: SizedBox(
                          width: double.infinity,
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                (name != null ? name : ""),

                                //you might have to add another text widget depending on how you retrieve it
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Baloo'),
                              )))),
                  SizedBox(height: 50),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        'البريد الإلكتروني :',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo'),
                      )),
                  SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              (email != null ? email : ""),

                              //you might have to add another text widget depending on how you retrieve it
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Baloo'),
                            ),
                          ))),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: 220,
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF2F69BC))),
                          onPressed: () async {
                            await signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePageGuest()),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text(
                                "خروج",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Baloo'),
                              )))),
                ],
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
