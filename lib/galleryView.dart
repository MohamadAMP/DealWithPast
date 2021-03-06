// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';

import 'Gallery/galleryTile.dart';

// ignore: must_be_immutable
class GalleryView extends StatelessWidget {
  dynamic stories;
  dynamic token;
  GalleryView(this.stories, this.token, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF252422),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  // shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: stories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GalleryTile(stories[index], token);
                  })),
          SizedBox(
            height: 30,
          )
        ]));
  }
}
