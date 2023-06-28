// ignore_for_file: file_names, unused_import, library_prefixes, prefer_typing_uninitialized_variables, avoid_print, empty_catches

import 'dart:convert';
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
import 'package:webview_flutter/webview_flutter.dart';
import "package:collection/collection.dart";
import 'package:path_provider/path_provider.dart';

import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import '../galleryView.dart';

class Gallery extends StatefulWidget {
  const Gallery({Key? key}) : super(key: key);

  @override
  _Gallery createState() => _Gallery();
}

class _Gallery extends State<Gallery> {
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
  UserRepo userRepo = UserRepo();
  var token;
  // late Coordinates coordinates;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/stories.json');
  }

  Future<dynamic> readCounter() async {
    try {
      var stor = [];
      final file = await _localFile;
      final contents = await file.readAsString();
      var data = await json.decode(contents);
      for (int i = 0; i < data.length; i++) {
        stories.add(Story.fromJson(data[i]));
      }
      return stor;
    } catch (e) {
      return 0;
    }
  }

  retrieveStories() async {
    try {
      await readCounter();
      // token = await userRepo.Authenticate("admin", "admin_1234");
      // stories = await storyrepo.getStories(token);
      return stories;
    } catch (e) {}
  }

  // late AnimationController controller;

  @override
  void initState() {
    super.initState();
    retrieveStories();

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
            return GalleryView(stories, token);
          }
        });
  }
}
