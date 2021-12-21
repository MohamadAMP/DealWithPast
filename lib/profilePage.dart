//Display Professional Profile (Professional View)

// ignore_for_file: file_names, deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:interactive_map/Login.dart';
import 'package:interactive_map/auth.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  Profile();
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;

  var url = FirebaseAuth.instance.currentUser!.photoURL;

  void click() {}

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
          color: Colors.black54,
          height: 190,
          child: Padding(
            padding: EdgeInsets.only(left: 30.0, top: 30.0),
            child: Column(
              children: <Widget>[
                Row(
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
                            image: NetworkImage(url!),
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          (name != null ? name : ""),

                          //you might have to add another text widget depending on how you retrieve it
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          (email != null ? email : ""),

                          //you might have to add another text widget depending on how you retrieve it
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            },
                            child: Text("signout"))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 25,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: 32.0, right: 32.0),
            child: Center(
                child: Text(
              "Published Posts:",
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ))),
      ]),
    ));
  }
}
