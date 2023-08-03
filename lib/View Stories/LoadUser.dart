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
import 'package:interactive_map/Gallery/Gallery.dart';
import 'package:interactive_map/Repos/UserInfo.dart';
import 'package:interactive_map/Repos/UserRepo.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetAll.dart';
import 'package:interactive_map/View%20Stories/StoryWidgetImgOnly.dart';
import 'package:interactive_map/View%20Stories/ViewPending.dart';
import 'package:interactive_map/View%20Stories/template.dart';
import 'package:interactive_map/profilePage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Repos/StoryClass.dart';
import '../Repos/StoryRepo.dart';
import '../Repos/UserClass.dart';

class ViewStoryStart extends StatefulWidget {
  dynamic id;
  dynamic gallery;
  dynamic story;
  dynamic location;
  dynamic pending;
  ViewStoryStart(this.id, this.gallery, this.story, this.location, this.pending,
      {Key? key})
      : super(key: key);

  @override
  _ViewStoryStart createState() => _ViewStoryStart();
}

class _ViewStoryStart extends State<ViewStoryStart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pending) {
      return StoryWidgetPending(widget.story, widget.location, widget.id);
    } else {
      if (widget.gallery) {
        return StoryWidgetAll(widget.story, widget.location, widget.id);
      } else {
        return StoryWidgetImgOnly(widget.story, widget.location, widget.id);
      }
    }
  }
}
