// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:interactive_map/Gallery/Gallery.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
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
  int currentIndex = 2;
  Map<int, Widget> pageMap = {};
  Map<int, String> titleMap = {
    0: "الجدول الزمني",
    1: "Gallery",
    2: "الخريطة",
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
          fontStyle: FontStyle.italic),
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
    pageMap = {0: Timeline(), 1: const Gallery(), 2: MapPage()};
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
        items: const [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(label: "", icon: Icon(Icons.timeline)),
          BottomNavigationBarItem(
              label: "", icon: Icon(Icons.photo_library_outlined)),
          BottomNavigationBarItem(label: "", icon: Icon(Icons.map_outlined)),
        ],
      ),
    );
  }
}
