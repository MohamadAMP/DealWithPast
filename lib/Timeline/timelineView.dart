// ignore_for_file: file_names, unused_import, avoid_function_literals_in_foreach_calls, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
import 'package:interactive_map/galleryView.dart';
import 'package:interactive_map/Timeline/viewStoriesTimeline.dart';

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
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 200.0,
                      color: Color(0xFF31302D),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          convertToArabicNumber(widget
                                                  .stories[index][0].event_date
                                                  .toString()
                                                  .split("T")
                                                  .toList()[0]
                                                  .split('-')[0]
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
                                                            widget
                                                                .stories[index],
                                                            convertToArabicNumber(widget
                                                                    .stories[
                                                                        index]
                                                                        [0]
                                                                    .event_date
                                                                    .toString()
                                                                    .split("T")
                                                                    .toList()[0]
                                                                    .split(
                                                                        '-')[0]
                                                                    .toString()
                                                                    .substring(
                                                                        0, 3) +
                                                                "0"),
                                                            widget.token)),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward,
                                              color: Color(0xFFFFDE73),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        widget.stories[index][0]
                                                            .featured_image,
                                                      ),
                                                      fit: BoxFit.cover),
                                                  // border: Border.all(width: 3.0),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0))),
                                            ),
                                            SizedBox(
                                              width: 40,
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 110,
                                                  child: Text(
                                                    widget.stories[index][0]
                                                        .title,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Text(
                                                    convertToArabicNumber(widget
                                                        .stories[index][0]
                                                        .event_date
                                                        .toString()
                                                        .split("T")
                                                        .toList()[0]
                                                        .split('-')[0]
                                                        .toString()),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16)),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ]),
                            ]),
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
