// ignore_for_file: file_names, unused_import, library_prefixes, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, empty_catches

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:interactive_map/Repos/UserInfo.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import 'StoriesView.dart';

class Stories extends StatefulWidget {
  const Stories({Key? key}) : super(key: key);

  @override
  _Stories createState() => _Stories();
}

class _Stories extends State<Stories> {
  StoryRepo storyrepo = StoryRepo();
  UserInfoRepo userRepo = UserInfoRepo();
  List<dynamic> stories = [];
  List<Story> published = [];
  List<Story> submitted = [];
  List<UserData> userData = [];
  List<dynamic> all_stories = [];
  UserRepo userRepoTok = UserRepo();
  var token;
  User? user = FirebaseAuth.instance.currentUser;

  retrieveStories() async {
    try {
      dynamic email = user!.email;
      token = await userRepoTok.Authenticate("admin", "admin_1234");
      var userInfo = await userRepo.getUserInfoByEmail(
          FirebaseAuth.instance.currentUser!.email.toString(),
          token);
      var id = userInfo[0].id;
      var stories_published = await storyrepo.getStoriesByAuthor(id, token);
      var stories_submitted =
          await storyrepo.getStoriesPendingByAuthor(id, token);
      stories_published.forEach((e) {
        if (e.status == "publish") {
          published.add(e);
        }
      });
      stories_submitted.forEach((e) {
        if (e.status == "pending") {
          submitted.add(e);
        }
      });
      all_stories.add(published);
      all_stories.add(submitted);
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
            return StoriesView(all_stories, token);
          }
        });
  }
}
