//Display Professional Profile (Professional View)

// ignore_for_file: file_names, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_if_null_operators

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Homepages/mainPageGuest.dart';

import 'Backend/auth.dart';
import 'Repos/UserInfo.dart';
import 'Repos/UserRepo.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  dynamic url;
  Profile(this.url);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          color: Color(0xFF31302D),
          height: MediaQuery.of(context).size.height * 0.23,
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
                            image: NetworkImage(widget.url),
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
                    ),
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
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(height: 20),
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
                                ),
                              )))),
                  SizedBox(height: 20),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
                      child: Text(
                        'البريد الإلكتروني :',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                              ),
                            ),
                          ))),
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFFFFDE73))),
                          onPressed: () async {
                            await signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomePageGuest()),
                            );
                          },
                          child: Text(
                            "خروج",
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ))),
                ],
              ),
            ],
          ),
        ),
      ]),
    ));
  }
}
