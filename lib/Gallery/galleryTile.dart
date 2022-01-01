// ignore_for_file: file_names, unused_import, avoid_function_literals_in_foreach_calls, prefer_const_constructors, unused_local_variable, avoid_unnecessary_containers, empty_catches, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:interactive_map/View%20Stories/LoadUser.dart';

import '../Repos/StoryClass.dart';
import '../Repos/UserClass.dart';
import '../Repos/UserInfo.dart';
import '../Repos/UserRepo.dart';
import '../View Stories/StoryWidgetImgOnly.dart';

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
    return Card(
        color: Color(0xFF31302D),
        elevation: 10.0,
        // margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        story.featured_image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      story.title,
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      story.event_date == ''
                          ? ""
                          : convertToArabicNumber(story.event_date
                              .toString()
                              .split("/")[2]
                              .toString()),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextButton(
                  onPressed: () async {
                    if (story.gallery == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStoryStart(story.author,
                                false, story, story.locationName, false)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStoryStart(story.author,
                                true, story, story.locationName, false)),
                      );
                    }
                  },
                  child: Text(
                    "اقرأ المزيد",
                    style: TextStyle(color: Color(0xFFFFDE73)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
