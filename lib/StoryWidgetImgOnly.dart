// ignore_for_file: file_names, sized_box_for_whitespace, duplicate_ignore, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:interactive_map/mainPage.dart';
import 'Repos/StoryClass.dart';
import 'Repos/UserClass.dart';
import 'package:carousel_slider/carousel_slider.dart';

// ignore: must_be_immutable
class StoryWidgetImgOnly extends StatelessWidget {
  Story story;
  dynamic location;
  UserData userData;
  StoryWidgetImgOnly(this.story, this.location, this.userData, {Key? key})
      : super(key: key);
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
    if (story.anonymous != false) {
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
                              userData.image,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          children: [
                            Text(
                              userData.name,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[2]) +
                                  "-" +
                                  convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[1]) +
                                  "-" +
                                  convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[0]),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        body: Body(story, location, userData),
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
                        Column(
                          children: [
                            Text(
                              "مجهول",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[2]) +
                                  "-" +
                                  convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[1]) +
                                  "-" +
                                  convertToArabicNumber(story.date_submitted
                                      .split("T")[0]
                                      .split("-")[0]),
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        body: Body(story, location, userData),
      );
    }
  }
}

class Body extends StatelessWidget {
  Story story;
  dynamic location;
  UserData userData;
  Body(this.story, this.location, this.userData, {Key? key}) : super(key: key);
  String removeAllHtmlTags(String htmlText) {
    return htmlText.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ' ');
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

  @override
  Widget build(BuildContext context) {
    dynamic desc = removeAllHtmlTags(story.description);
    List<dynamic> myList = [
      Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              // ignore: avoid_unnecessary_containers
              child: Container(
                height: 250,
                // height: 60,
                // width: 60,
                child: Image.network(
                  story.featured_image,
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
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ));
                  },
                ),
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
                        color: Color(0xFFFFDE73),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        location,
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
                        story.title,
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
                        convertToArabicNumber(story.event_date
                            .toString()
                            .split("T")
                            .toList()[0]
                            .split('-')[0]
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
