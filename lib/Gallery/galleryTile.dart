// ignore_for_file: file_names, unused_import, avoid_function_literals_in_foreach_calls, prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, empty_catches, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:interactive_map/View%20Stories/LoadUser.dart';
import 'dart:math' as math;

import '../Repos/StoryClass.dart';
import '../Repos/UserClass.dart';
import '../Repos/UserInfo.dart';
import '../Repos/UserRepo.dart';
import '../View Stories/StoryWidgetImgOnly.dart';
// import this

// ignore: must_be_immutable
class GalleryTile extends StatelessWidget {
  final Story story;
  final dynamic token;
  GalleryTile(this.story, this.token, {Key? key}) : super(key: key);

  List<UserData> userData = [];
  dynamic location;
  late dynamic placemarks;
  late dynamic image;
  retrieveUserInfo(
      UserInfoRepo userInfoRepo, UserRepo userRepo, dynamic id) async {
    try {
      var tok = await userRepo.Authenticate("admin", "admin_1234");

      userData = await userInfoRepo.getUserInfo(id, tok);
      // EasyLoading.showSuccess("Stories Loaded");
    } catch (e) {}
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
    double width = MediaQuery.of(context).size.width;
    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        height: 250,
        child: Stack(
          children: [
            Container(

                // elevation: 10.0,
                // margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          story.featured_image,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container())),
            Positioned.fill(
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    // margin: EdgeInsetsGeometry.lerp(a, b, t),
                    height: 65,
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                        onTap: () async {
                          if (story.gallery == false) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewStoryStart(
                                      story.author,
                                      false,
                                      story,
                                      story.locationName,
                                      false)),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewStoryStart(
                                      story.author,
                                      true,
                                      story,
                                      story.locationName,
                                      false)),
                            );
                          }
                        },
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
                                      story.title,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontFamily: 'Baloo',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 23, 0),
                                    child: Row(children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          story.event_date == ''
                                              ? ""
                                              : convertToArabicNumber(story
                                                      .event_date
                                                      .toString()
                                                      .split("/")[0]
                                                      .toString()) +
                                                  ' - ' +
                                                  story.locationName,
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
                        ))),
                  )),
            ),
          ],
        ));
  }
}
