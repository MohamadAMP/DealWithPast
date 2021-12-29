// ignore_for_file: file_names, unused_import, must_be_immutable, avoid_function_literals_in_foreach_calls, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:interactive_map/My%20Stories/addStory.dart';
import '../Repos/StoryClass.dart';
import 'myStoriesTile.dart';

class StoriesView extends StatefulWidget {
  List<dynamic> stories;
  dynamic token;
  StoriesView(this.stories, this.token, {Key? key}) : super(key: key);

  @override
  _StoriesView createState() => _StoriesView();
}

class _StoriesView extends State<StoriesView> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const TabBar(
              tabs: [
                Tab(
                  child: Text("موافق عليها"),
                ),
                Tab(child: Text("في انتظار الموافقة")),
              ],
            ),
          ),
          body: Stack(
            children: [
              TabBarView(
                children: [
                  Container(
                      color: Color(0xFF252422),
                      child: widget.stories[0].isEmpty
                          ? Center(
                              child: const Text("لا توجد روايات موافق عليها",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 28)))
                          : Align(
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                  // shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: widget.stories[0].length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return StoryTile(
                                        widget.stories[0][index], widget.token);
                                  }))),
                  Container(
                    color: Color(0xFF252422),
                    child: widget.stories[1].isEmpty
                        ? Center(
                            child: const Text("لا توجد روايات بانتظار مواققة",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28)))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: widget.stories[1].length,
                            itemBuilder: (BuildContext context, int index) {
                              return StoryTile(
                                  widget.stories[1][index], widget.token);
                            }),
                  )
                ],
              ),
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    child: const Icon(
                      Icons.add,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3)),
                  ),
                  foregroundColor: Color(0xFF252422),
                  backgroundColor: Color(0xFFFFDE73),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddStory(widget.token)),
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
