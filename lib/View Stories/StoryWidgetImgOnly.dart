// ignore_for_file: file_names, deprecated_member_use, unused_import, avoid_function_literals_in_foreach_calls, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, duplicate_ignore, non_constant_identifier_names

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
import 'dart:math' as math;

class StoryWidgetImgOnly extends StatefulWidget {
  Story story;
  dynamic location;
  UserData userData;
  StoryWidgetImgOnly(this.story, this.location, this.userData, {Key? key})
      : super(key: key);

  @override
  _StoryWidgetImgOnlyState createState() => _StoryWidgetImgOnlyState();
}

String convertToArabicNumber(String number) {
  String res = '';

  final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  number.characters.forEach((element) {
    res += arabics[int.parse(element)];
  });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
  return res;
}

enum SocialMedia { facebook, twitter, whatsapp, instagram }

class _StoryWidgetImgOnlyState extends State<StoryWidgetImgOnly> {
  Future share(SocialMedia socialPlatform) async {
    final text = widget.story.title + " ";
    final urlShare = Uri.encodeComponent(widget.story.link);

    final urls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
      SocialMedia.twitter:
          'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
      // SocialMedia.instagram:
      //     'https://www.facebook.com/sharer/sharer.php?u=$urlShare&t=$text',
      SocialMedia.whatsapp: 'https://api.whatsapp.com/send?text=$text$urlShare',
    };
    final urlFinal = urls[socialPlatform];

    if (await canLaunch(urlFinal!)) {
      await launch(urlFinal);
    }
  }

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
                            onPressed: () {
                              share(SocialMedia.facebook);
                              Navigator.pop(context);
                            },
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
                            onPressed: () {
                              share(SocialMedia.twitter);
                              Navigator.pop(context);
                            },
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
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.story.link));
                              Navigator.pop(context);
                            },
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
                            onPressed: () {
                              share(SocialMedia.whatsapp);
                              Navigator.pop(context);
                            },
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
                      onPressed: () => {
                        Navigator.pop(context),
                      },
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
    if (widget.story.anonymous.length == 0) {
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
                              widget.userData.image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        // Column(
                        //   children: [
                        //     Text(
                        //       widget.userData.name,
                        //       style: TextStyle(fontSize: 16),
                        //     ),
                        //     Text(
                        //       convertToArabicNumber(widget.story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[2]) +
                        //           "-" +
                        //           convertToArabicNumber(widget
                        //               .story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[1]) +
                        //           "-" +
                        //           convertToArabicNumber(widget
                        //               .story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[0]),
                        //       style: TextStyle(fontSize: 16),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Color(0xFFFFDE73),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _share();
                    },
                    child: const Text(
                      "شارك",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Baloo'),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
        body: Body(widget.story, widget.location, widget.userData),
      );
    } else {
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
                        //     Text(
                        //       "مجهول",
                        //       style: TextStyle(fontSize: 16),
                        //     ),
                        //     Text(
                        //       convertToArabicNumber(widget.story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[2]) +
                        //           "-" +
                        //           convertToArabicNumber(widget
                        //               .story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[1]) +
                        //           "-" +
                        //           convertToArabicNumber(widget
                        //               .story.date_submitted
                        //               .split("T")[0]
                        //               .split("-")[0]),
                        //       style: TextStyle(fontSize: 16),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  margin: EdgeInsets.all(10),
                  child: MaterialButton(
                    color: Color(0xFFFFDE73),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      _share();
                    },
                    child: const Text(
                      "شارك",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'Baloo'),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
        body: Body(widget.story, widget.location, widget.userData),
      );
    }
  }
}

class Body extends StatefulWidget {
  Story story;
  dynamic location;
  UserData userData;
  Body(this.story, this.location, this.userData, {Key? key}) : super(key: key);

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
    dynamic desc = removeAllHtmlTags(widget.story.description);
    List<dynamic> myList = [
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // ignore: avoid_unnecessary_containers
              child: Stack(
                children: [
                  Container(
                    height: 250,
                    // height: 60,
                    // width: 60,
                    child: Image.network(
                      widget.story.featured_image,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                            child: Padding(
                          padding: const EdgeInsets.all(100),
                          child: CircularProgressIndicator(
                            color: Color(0xFFFFDE73),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ));
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          // margin: EdgeInsetsGeometry.lerp(a, b, t),
                          height: 65,
                          color: Colors.black.withOpacity(0.5),
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          alignment: Alignment.bottomRight,

                          child: Container(
                              child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                children: [
                                  Row(children: [
                                    Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(math.pi),
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Color(0xFFE0C165),
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        widget.story.title,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontFamily: 'Baloo',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]),
                                  Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                                      child: Row(children: [
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            widget.story.event_date == ''
                                                ? ""
                                                : convertToArabicNumber(widget
                                                        .story.event_date
                                                        .toString()
                                                        .split("/")[0]
                                                        .toString()) +
                                                    ' - ' +
                                                    widget.story.locationName,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontFamily: 'Baloo',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ])),
                                ],
                              ),
                            ],
                          )),
                        )),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_pin,
                        color: Color(0xFF2F69BC),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.location,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color(0xFF2F69BC),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.story.targeted_person,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: Color(0xFF2F69BC),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.story.event_date == ''
                            ? ""
                            : convertToArabicNumber(widget.story.event_date
                                .toString()
                                .split("/")[0]
                                .toString()),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  child: Directionality(
                    child: Text(
                      desc,
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          )
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
            // physics: const NeverScrollableScrollPhysics(),
            itemCount: myList.length,
            itemBuilder: (BuildContext context, int index) {
              return myList[index];
            }));
  }
}
