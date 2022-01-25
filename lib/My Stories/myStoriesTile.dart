// ignore_for_file: file_names, unused_import, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:interactive_map/View%20Stories/LoadUser.dart';
import '../Repos/StoryClass.dart';
import '../Repos/UserClass.dart';
import '../Repos/UserInfo.dart';
import '../View Stories/StoryWidgetImgOnly.dart';

// ignore: must_be_immutable
class StoryTile extends StatelessWidget {
  final Story story;
  dynamic token;
  dynamic pending;
  StoryTile(this.story, this.token, this.pending, {Key? key}) : super(key: key);

  List<UserData> userData = [];
  dynamic location;
  late dynamic placemarks;
  late dynamic image;
  retrieveUserInfo(UserInfoRepo userInfoRepo, dynamic id) async {
    try {
      userData = await userInfoRepo.getUserInfo(id, token);
      // EasyLoading.showSuccess("Stories Loaded");
    } catch (e) {
      // ignore: avoid_print
    }
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
    return Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                height: 80,
                width: 80,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    story.featured_image,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      story.title,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Baloo'),
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
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Baloo'),
                    ),
                  ),
                ],
              ),
              // SizedBox(width),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFFFDE73),
                  ),
                  onPressed: () async {
                    if (story.gallery == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStoryStart(story.author,
                                false, story, story.locationName, pending)),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewStoryStart(story.author,
                                true, story, story.locationName, pending)),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
