// ignore_for_file: file_names, unused_import, library_prefixes, non_constant_identifier_names, duplicate_ignore, prefer_typing_uninitialized_variables, avoid_function_literals_in_foreach_calls, empty_catches

import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as IMG;
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:interactive_map/Timeline/timelineView.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import '../galleryView.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  StoryRepo storyrepo = StoryRepo();
  List<Story> stories = [];
  List<UserData> userData = [];
  List<Marker> allMarkers = [];
  late BitmapDescriptor pinIcon;
  // ignore: non_constant_identifier_names
  bool Loaded = false;
  bool showPage = false;
  dynamic location;
  late Story mainStory;
  late dynamic placemarks;
  late dynamic image;
  List<dynamic> all_stories = [];
  List<Story> stories_1950 = [];
  List<Story> stories_1960 = [];
  List<Story> stories_1970 = [];
  List<Story> stories_1980 = [];
  List<Story> stories_1990 = [];
  List<Story> stories_2000 = [];
  List<Story> stories_2010 = [];
  var minimum = 2030;
  dynamic intervals;
  UserRepo userRepo = UserRepo();
  var token;
  // late Coordinates coordinates;

  retrieveStories() async {
    try {
      token = await userRepo.Authenticate("admin", "admin_1234");
      stories = await storyrepo.getStories(token);
      stories.forEach((element) {
        if (element.event_date != "") {
          String year = element.event_date.toString().split("/")[2].toString();
          var yearInt = int.parse(year);

          if (yearInt < minimum) {
            minimum = yearInt;
            minimum = int.parse(minimum.toString().substring(0, 3) + "0");
          }
        }
      });
      var lowerBound = minimum;
      intervals = (2030 - minimum) ~/ 10;
      for (int i = 0; i < intervals; i++) {
        var list = [];
        stories.forEach((element) {
          if (element.event_date != "") {
            String year =
                element.event_date.toString().split("/")[2].toString();
            var yearInt = int.parse(year);
            if (yearInt >= lowerBound + (10 * (i)) &&
                yearInt < lowerBound + (10 * (i + 1))) {
              list.add(element);
            }
          }
        });
        if (list.isNotEmpty) {
          all_stories.add(list);
        }
      }
      return all_stories;
    } catch (e) {}
  }

  // late AnimationController controller;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveStories(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                backgroundColor: Color(0xFF252422),
                body: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFFFDE73),
                )));
          } else {
            // return Container();
            return TimelineView(all_stories, token);
          }
        });
  }
}
