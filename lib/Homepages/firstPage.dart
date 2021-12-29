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
import 'package:interactive_map/Homepages/mainPageGuest.dart';
import 'package:interactive_map/Repos/UserInfo.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:location/location.dart' as locationPerm;
import 'package:flutter/cupertino.dart';
import 'package:place_picker/entities/localization_item.dart';
import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';
import 'mainPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPage createState() => _FirstPage();
}

retrieveUser() async {
  try {
    if (FirebaseAuth.instance.currentUser != null) {
      UserRepo userRepo = UserRepo();
      if (await userRepo.AuthenticateOther(
              FirebaseAuth.instance.currentUser!.email.toString().split('@')[0],
              FirebaseAuth.instance.currentUser!.uid) ==
          false) {
        return false;
      } else {
        await signOut();
        return true;
      }
    } else {
      return false;
    }
  } catch (e) {}
}

class _FirstPage extends State<FirstPage> {
  locationPerm.Location locationAcc = locationPerm.Location();
  late bool _serviceEnabled;
  late locationPerm.PermissionStatus _permissionGranted;
  late locationPerm.LocationData _locationData;
  late dynamic currLng;
  late dynamic currLat;

  void locationAccess() async {
    _serviceEnabled = await locationAcc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationAcc.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await locationAcc.hasPermission();
    if (_permissionGranted == locationPerm.PermissionStatus.denied) {
      _permissionGranted = await locationAcc.requestPermission();
      if (_permissionGranted != locationPerm.PermissionStatus.granted) {
        return;
      }
    }
    var currLoc = await locationAcc.getLocation();
    setState(() {
      currLat = currLoc.latitude;
      currLng = currLoc.longitude;
    });
  }

  @override
  initState() {
    super.initState();
    locationAccess();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
                backgroundColor: Color(0xFF252422),
                body: Center(
                    child: CircularProgressIndicator(
                  color: Color(0xFFFFDE73),
                )));
          } else {
            if (snapshot.data == true) {
              return WelcomePage();
            } else {
              return WelcomePageGuest();
            }
          }
        });
  }
}
