// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:interactive_map/Gallery/Gallery.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
import 'package:interactive_map/My%20Stories/addStoryGuest.dart';
import 'package:interactive_map/profilePage.dart';
import 'package:interactive_map/Timeline/timeline.dart';
import '../Map/map.dart';

class WelcomePageGuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: const Center(child: Text('Interactive Map')),
      // ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  int currentIndex = 3;
  Map<int, Widget> pageMap = {};
  Map<int, String> titleMap = {
    0: "أضف رواية",
    1: "الجدول الزمني",
    2: "عرض الروايات",
    3: "Memory Map",
  };
  late Widget appBarContent, appBarText;
  late TextEditingController appBarController;

  setAppBar() {
    appBarText = Text(
      titleMap[currentIndex]!,
      style: const TextStyle(
          letterSpacing: 2,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          // fontStyle: FontStyle.italic,
          fontFamily: 'Baloo',
          color: Color(0xFFE0C165)),
    );

    appBarContent = appBarText;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
      setAppBar();
      appBarController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    appBarController = TextEditingController();
    // ignore: prefer_const_constructors
    pageMap = {
      0: AddStoryGuest(),
      1: const Timeline(),
      2: const Gallery(),
      3: const MapPage()
    };
    setAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarContent,
        backgroundColor: Colors.black.withOpacity(0.8),
        // elevation: 0,
        // ignore: deprecated_member_use
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
      ),
      body: pageMap[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        fixedColor: Colors.white,
        unselectedItemColor: const Color(0x60FFFFFF),
        currentIndex: currentIndex,
        onTap: (index) {
          changePage(index);
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
              label: "", icon: Icon(Icons.photo_album_outlined)),

          BottomNavigationBarItem(label: "", icon: Icon(Icons.timeline)),
          BottomNavigationBarItem(
              label: "", icon: Icon(Icons.photo_library_outlined)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.map_outlined)),
        ],
      ),
    );
  }
}
