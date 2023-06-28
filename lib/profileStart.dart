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
import 'package:interactive_map/Backend/auth.dart';
import 'package:interactive_map/Repos/UserInfo.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:interactive_map/profilePage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';

class ProfileStart extends StatefulWidget {
  const ProfileStart({Key? key}) : super(key: key);

  @override
  _ProfileStart createState() => _ProfileStart();
}

class _ProfileStart extends State<ProfileStart> {
  UserInfoRepo userRepo = UserInfoRepo();

  UserRepo userRepoTok = UserRepo();
  late var url;

  getImage() async {
    var eml = FirebaseAuth.instance.currentUser!.email.toString();
    var tst = eml.split("@")[0];
    var token = await userRepoTok.Authenticate("admin", "Admin_12345");
    var userInfo = await userRepo.getUserInfoByEmail(
        FirebaseAuth.instance.currentUser!.email.toString(), token);
    return [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getImage(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                backgroundColor: Color(0xFF252422),
                body: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFFFDE73),
                )));
          } else {
            return Profile(snapshot.data);
          }
        });
  }
}
