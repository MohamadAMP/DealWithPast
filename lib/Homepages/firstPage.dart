// ignore_for_file: file_names, unused_import, library_prefixes, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, empty_catches

import 'dart:convert';
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
import 'package:path_provider/path_provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPage createState() => _FirstPage();
}

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
    final file = await _localFile;
    final contents = await file.readAsString();
    return contents;
  } catch (e) {
    return 0;
  }
}

Future<void> writeCounter(dynamic stories) async {
  final file = await _localFile;
  return file.writeAsStringSync(json.encode(stories));
}

retrieveUser() async {
  // UserRepo userRepo = UserRepo();
  // final UserInfoRepo _userRepo = UserInfoRepo();
  // var token = await userRepo.Authenticate("admin", "admin_1234");
  // var temp = await _userRepo.getUserInfoByEmail("msabra1731", token);
  // print(temp.runtimeType);
  try {
    UserRepo userRepo = UserRepo();
    StoryRepo storyrepo = StoryRepo();

    var token = await userRepo.Authenticate("admin", "admin_1234");
    final response = await http.get(
        Uri.parse('http://dwp.world/wp-json/wp/v2/stories/?per_page=100'),
        headers: {
          "connection": "keep-alive",
          'Authorization': 'Bearer $token',
        });
    int x = int.parse(response.headers['x-wp-totalpages']!);

    List<dynamic> stories = [];
    for (int i = 0; i < x; i++) {
      final response = await http.get(
          Uri.parse(
              'http://dwp.world/wp-json/wp/v2/stories/?per_page=100&page=' +
                  (i + 1).toString()),
          headers: {
            "connection": "keep-alive",
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data.forEach((e) {
          if (e['acf']['event_date'] != '' &&
              e['acf']['map_location'] != false) {
            stories.add(e);
          }
        });
      }
    }

    await writeCounter(stories);
    if (FirebaseAuth.instance.currentUser != null) {
      UserRepo userRepo = UserRepo();
      if (await userRepo.AuthenticateOther(
              FirebaseAuth.instance.currentUser!.email.toString().split('@')[0],
              FirebaseAuth.instance.currentUser!.uid) ==
          false) {
        await signOut();
        return false;
      } else {
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

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: retrieveUser(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
                backgroundColor: const Color(0xFF252422),
                body: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      Center(
                        child: Container(
                            height: 200,
                            width: 200,
                            child: Image.asset('assets/logo.png')),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      const Center(
                          child: Text('خارطة وذاكرة',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                              )))
                    ])));
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
