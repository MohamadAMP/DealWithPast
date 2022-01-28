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

class StoryWidgetPending extends StatefulWidget {
  Story story;
  dynamic location;
  UserData userData;
  StoryWidgetPending(this.story, this.location, this.userData, {Key? key})
      : super(key: key);

  @override
  _StoryWidgetPendingState createState() => _StoryWidgetPendingState();
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

class _StoryWidgetPendingState extends State<StoryWidgetPending> {
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
            ]),
          ),
        ),
      ),
      body: Body(widget.story, widget.location, widget.userData),
    );
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
  var show = true;

  String removeAllHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
  }

  var documents = [];
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    if (Platform.isIOS) WebView.platform = CupertinoWebView();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> carousel = [
      Image.network(
        widget.story.featured_image,
        fit: BoxFit.cover,
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
    ];
    if (widget.story.gallery != false) {
      widget.story.gallery.forEach((element) {
        var mime_type = element['mime_type'];
        var type = mime_type.toString().split('/')[0];
        if (type == 'image') {
          carousel.add(
            Image.network(
              element['url'],
              fit: BoxFit.cover,
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
          );
        } else if (type == 'video' || type == 'audio') {
          carousel.add(WebView(
            initialUrl: element['url'],
            javascriptMode: JavascriptMode.unrestricted,
          ));
        } else {
          var link = element['url'];
          carousel.add(InkWell(
              onTap: () async {
                var url = link;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: link.split('.').last == 'pdf'
                  ? Container(child: Image.asset('assets/pdf-image.png'))
                  : Container(child: Image.asset('assets/word-image.png'))));
        }
      });
    }
    if (documents.length != 0) {
      documents.forEach((element) {
        var link = element;
        carousel.add(InkWell(
            onTap: () async {
              var url = link;
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: link.split('.').last == 'pdf'
                ? Container(child: Image.asset('assets/pdf-image.png'))
                : Container(child: Image.asset('assets/word-image.png'))));
      });
    }

    dynamic desc = removeAllHtmlTags(widget.story.description);
    var length = convertToArabicNumber((carousel.length).toString());
    List<dynamic> myList = [
      Stack(
        children: [
          Column(children: [
            CarouselSlider.builder(
              itemCount: carousel.length,
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  if (carousel[index].toString().split('(')[0].toString() !=
                      'Image') {
                    setState(() {
                      show = false;
                      print(carousel);
                    });
                  } else {
                    setState(() {
                      show = true;
                      print(carousel);
                    });
                  }
                },
                height: 250.0,
                viewportFraction: 1,
                enableInfiniteScroll: false,
              ),
              itemBuilder: (context, itemIndex, realIndex) {
                var i = convertToArabicNumber((itemIndex + 1).toString());
                return Stack(children: [
                  Container(width: double.infinity, child: carousel[itemIndex]),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            "$i من $length",
                            style: TextStyle(color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        )),
                  ),
                ]);
              },
            ),
          ]),
          show
              ? Positioned.fill(
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
                )
              : Container()
        ],
      ),
      Column(
        children: [
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
                        color: Color(0xFFFFDE73),
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
                        color: Color(0xFFFFDE73),
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
                        color: Color(0xFFFFDE73),
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
