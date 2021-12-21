// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:interactive_map/StoryWidgetAudio.dart';
import 'package:interactive_map/StoryWidgetAll.dart';

import 'Repos/StoryClass.dart';
import 'Repos/UserClass.dart';
import 'Repos/UserInfo.dart';
import 'Repos/UserRepo.dart';
import 'StoryWidgetImgOnly.dart';
import 'StoryWidgetVideo.dart';

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
    } catch (e) {
      EasyLoading.showError("Could not retrieve Stories");
      // ignore: avoid_print
      print(e);
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
              // ignore: sized_box_for_whitespace
              Expanded(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      story.featured_image,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // decoration: BoxDecoration(
                //     image: DecorationImage(
                //         image: NetworkImage(
                //           story.featured_image,
                //         ),
                //         fit: BoxFit.contain),
                //     // border: Border.all(width: 3.0),
                //     borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      convertToArabicNumber(story.event_date
                          .toString()
                          .split("T")
                          .toList()[0]
                          .split('-')[0]
                          .toString()),
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              // SizedBox(width),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextButton(
                  onPressed: () async {
                    UserInfoRepo userInfoRepo = UserInfoRepo();
                    UserRepo userRepo = UserRepo();
                    await retrieveUserInfo(
                        userInfoRepo, userRepo, story.author);

                    if (story.gallery == false) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryWidgetImgOnly(
                                story, story.locationName, userData[0])),
                      );
                    } else {
                      print(story.gallery);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StoryWidgetAll(
                                story, story.locationName, userData[0])),
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
