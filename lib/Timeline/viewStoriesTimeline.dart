// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import '../Gallery/galleryTile.dart';

// ignore: must_be_immutable
class TimelineStoriesView extends StatelessWidget {
  dynamic stories;
  dynamic year;
  dynamic token;
  TimelineStoriesView(this.stories, this.year, this.token, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text("روايات من  " + year),
          backgroundColor: Colors.black.withOpacity(0.8),
          // elevation: 0,
          // ignore: deprecated_member_use
          brightness: Brightness.light,
          automaticallyImplyLeading: false,
        ),
        body: Container(
            color: Color(0xFF252422),
            child: GridView.builder(
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: stories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GalleryTile(stories[index], token);
                })));
  }
}
