// ignore_for_file: file_names, unused_import, use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:interactive_map/ContactUs.dart';
import 'package:interactive_map/Gallery/Gallery.dart';
import 'package:interactive_map/Homepages/startPage.dart';
import 'package:interactive_map/My%20Stories/Stories.dart';
import 'package:interactive_map/profilePage.dart';
import 'package:interactive_map/Timeline/timeline.dart';
import 'package:interactive_map/profileStart.dart';
import '../Map/map.dart';

class WelcomePage extends StatelessWidget {
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
  int currentIndex = 6;
  Map<int, Widget> pageMap = {};
  Map<int, String> titleMap = {
    0: "تواصل معنا",
    1: "الحساب الشخصي",
    2: "الجدول الزمني",
    3: "رواياتي",
    4: "عرض الروايات",
    5: "الخارطه",
    6: 'خارطه و ذاكرة'
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
      0: ContactUs(),
      1: ProfileStart(),
      2: Timeline(),
      3: Stories(),
      4: Gallery(),
      5: MapPage(),
      6: StartPage(),
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
        items: [
          // ignore: prefer_const_constructors
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.contact_support)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.person)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.timeline)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.photo_album_outlined)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.photo_library_outlined)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.map_outlined)),
              ],
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 1,
                  height: 30,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.grey,
                      Colors.black,
                    ],
                  )),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: Icon(Icons.info_outline)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
