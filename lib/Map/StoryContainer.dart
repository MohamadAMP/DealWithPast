// ignore_for_file: file_names, non_constant_identifier_names, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

import '../Repos/StoryClass.dart';

Widget StoryContainer(Story story, BuildContext context) {
  return Container(
    height: 120,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 10, 8),
            child: Container(
                height: 60,
                width: 60,
                child: Image.asset("assets/images/image-icon.png")),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                story.title,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                "Located at: " + story.locationName,
                style: TextStyle(fontSize: 11),
              ),
              Text(
                "Submitted on " + story.date_submitted,
                style: TextStyle(fontSize: 11),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
