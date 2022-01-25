// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:interactive_map/Homepages/mainPage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Repos/StoryClass.dart';
import '../Repos/UserClass.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class StoryWidgetTemplate extends StatefulWidget {
  StoryWidgetTemplate({Key? key}) : super(key: key);

  @override
  _StoryWidgetTemplateState createState() => _StoryWidgetTemplateState();
}

enum SocialMedia { facebook, twitter, whatsapp, instagram }

class _StoryWidgetTemplateState extends State<StoryWidgetTemplate> {
  void _share() {
    final _aboutdialog = StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
          // ignore: prefer_const_constructors
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          title: Icon(Icons.share),
          content: Container(
              height: 250,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(child: Text("شارك")),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use
                        OutlineButton(
                            color: Colors.transparent,
                            borderSide: BorderSide(color: Colors.transparent),
                            onPressed: () {},
                            splashColor: Colors.grey[600],
                            // borderSide: BorderSide(color: Colors.grey),
                            child: Container(
                              child: Image(
                                fit: BoxFit.fitWidth,
                                image: AssetImage('assets/facebook.png'),
                                height: 45,
                                width: 45,
                              ),
                            )),
                        OutlineButton(
                            color: Colors.transparent,
                            borderSide: BorderSide(color: Colors.transparent),
                            onPressed: () {},
                            splashColor: Colors.grey[600],
                            child: Container(
                              child: Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('assets/twitter.png'),
                                  height: 45,
                                  width: 45),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: deprecated_member_use

                        OutlineButton(
                            color: Colors.transparent,
                            borderSide: BorderSide(color: Colors.transparent),
                            onPressed: () {},
                            splashColor: Colors.grey[600],
                            child: Container(
                              child: Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('assets/copy.png'),
                                  height: 45,
                                  width: 45),
                            )),
                        OutlineButton(
                            color: Colors.transparent,
                            borderSide: BorderSide(color: Colors.transparent),
                            onPressed: () {},
                            splashColor: Colors.grey[600],
                            child: Container(
                              child: Image(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage('assets/whatsapp.png'),
                                  height: 45,
                                  width: 45),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () => {},
                      child: Text(
                        "إستمرار",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Bahij",
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Color(0xFFCCAF41),
                      ),
                    ),
                  ])));
    });
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => _aboutdialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFF252422),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Container(
            child: Row(children: [
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://secure.gravatar.com/avatar/f78d1ea57fd11ad745f028584fc71774?s=24&d=mm&r=g",
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      // Column(
                      //   children: [
                      //     Container(
                      //       width: 60,
                      //       height: 12,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.grey,
                      //         borderRadius: BorderRadius.only(
                      //             topRight: Radius.circular(40.0),
                      //             bottomRight: Radius.circular(40.0),
                      //             topLeft: Radius.circular(40.0),
                      //             bottomLeft: Radius.circular(40.0)),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       height: 5,
                      //     ),
                      //     Container(
                      //       width: 85,
                      //       height: 12,
                      //       decoration: const BoxDecoration(
                      //         color: Colors.grey,
                      //         borderRadius: BorderRadius.only(
                      //             topRight: Radius.circular(40.0),
                      //             bottomRight: Radius.circular(40.0),
                      //             topLeft: Radius.circular(40.0),
                      //             bottomLeft: Radius.circular(40.0)),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String removeAllHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> myList = [
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // ignore: avoid_unnecessary_containers
              child: Container(
                height: 250,
                child: Image.asset(
                  'assets/default-image.png',
                  fit: BoxFit.fill,
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height - 370,
              width: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFFFDE73),
                ),
              ))
        ],
      )
    ];
    // ignore: avoid_unnecessary_containers
    return Container(
        height: double.infinity,
        color: Color(0xFF252422),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: myList.length,
            itemBuilder: (BuildContext context, int index) {
              return myList[index];
            }));
  }
}
