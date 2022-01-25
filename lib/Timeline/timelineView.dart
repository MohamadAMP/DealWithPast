// ignore_for_file: file_names, unused_import, avoid_function_literals_in_foreach_calls, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
import 'package:interactive_map/galleryView.dart';
import 'package:interactive_map/Timeline/viewStoriesTimeline.dart';
import 'dart:math' as math;

class TimelineView extends StatefulWidget {
  List<dynamic> stories;
  dynamic token;
  TimelineView(this.stories, this.token, {Key? key}) : super(key: key);

  @override
  _TimelineViewState createState() => _TimelineViewState();
}

class _TimelineViewState extends State<TimelineView> {
  String convertToArabicNumber(String number) {
    String res = '';

    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    number.characters.forEach((element) {
      res += arabics[int.parse(element)];
    });

/*   final latins = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']; */
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF252422),
        child: ListView.builder(
          itemCount: widget.stories.length,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 30),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.stories[index][0].featured_image,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // color: Color(0xFF31302D),
                      width: 336,
                      height: 250.0,
                      child: Container(
                        // padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Container(
                            child: Stack(children: [
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  color: Color(0xFF31302C),
                                  width: double.infinity,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 35, 0),
                                      child: Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            convertToArabicNumber(widget
                                                    .stories[index][0]
                                                    .event_date
                                                    .toString()
                                                    .split("/")[2]
                                                    .toString()
                                                    .substring(0, 3) +
                                                "0"),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TimelineStoriesView(
                                                              widget.stories[
                                                                  index],
                                                              convertToArabicNumber(widget
                                                                      .stories[
                                                                          index]
                                                                          [0]
                                                                      .event_date
                                                                      .toString()
                                                                      .split("/")[
                                                                          2]
                                                                      .toString()
                                                                      .substring(
                                                                          0,
                                                                          3) +
                                                                  "0"),
                                                              widget.token)),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward,
                                                color: Color(0xFFFFDE73),
                                              )),
                                        ],
                                      )),
                                )),
                          ),
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  // margin: EdgeInsetsGeometry.lerp(a, b, t),
                                  height: 55,
                                  color: Colors.black.withOpacity(0.5),
                                  padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
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
                                              transform:
                                                  Matrix4.rotationY(math.pi),
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: Color(0xFFE0C165),
                                              ),
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                widget.stories[index][0].title,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontFamily: 'Baloo',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ]),
                                          Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 25, 0),
                                              child: Row(children: [
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                    widget.stories[index][0]
                                                                .event_date ==
                                                            ''
                                                        ? ""
                                                        : convertToArabicNumber(
                                                                widget
                                                                    .stories[
                                                                        index]
                                                                        [0]
                                                                    .event_date
                                                                    .toString()
                                                                    .split(
                                                                        "/")[2]
                                                                    .toString()) +
                                                            ' - ' +
                                                            widget
                                                                .stories[index]
                                                                    [0]
                                                                .locationName,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontFamily: 'Baloo',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ])),
                                        ],
                                      ),
                                    ],
                                  )),
                                )),
                          ),
                        ])),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  left: 35.0,
                  child: Container(
                    height: double.infinity,
                    width: 1.0,
                    color: Color(0xFF757E7C),
                  ),
                ),
                Positioned(
                  top: 100.0,
                  left: 15.0,
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      height: 30.0,
                      width: 30.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFDE73)),
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
