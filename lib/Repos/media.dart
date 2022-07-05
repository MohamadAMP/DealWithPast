// ignore_for_file: file_names, avoid_print, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:interactive_map/Repos/UserRepo.dart';

class Media {
  Future<dynamic> uploadImage(filePath) async {
    UserRepo userRepo = UserRepo();
    var token = await userRepo.Authenticate('admin', 'admin_1234');
    String url = 'https://dwp.world/wp-json/wp/v2/media';

    String fileName = filePath.path.split('/').last;

    Map<String, String> requestHeaders = {
      'Content-Type': 'image/jpg',
      'Content-Disposition': 'attachment; filename=$fileName',
      'Authorization': 'Bearer $token',
    };
    List<int> imageBytes = File(filePath.path).readAsBytesSync();
    var request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(requestHeaders);
    request.bodyBytes = imageBytes;
    var res = await request.send();
    var content = await res.stream.bytesToString();
    return res.statusCode == 201 ? content : content;
  }

  Future<dynamic> uploadAll(filePath) async {
    UserRepo userRepo = UserRepo();
    var token = await userRepo.Authenticate('admin', 'admin_1234');
    String url = 'https://dwp.world/wp-json/wp/v2/media';

    String fileName = filePath.split('/').last;

    Map<String, String> requestHeaders = {
      'Content-Type': 'image/jpg',
      'Content-Disposition': 'attachment; filename=$fileName',
      'Authorization': 'Bearer $token',
    };
    List<int> imageBytes = File(filePath).readAsBytesSync();
    var request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(requestHeaders);
    request.bodyBytes = imageBytes;
    var res = await request.send();
    var content = await res.stream.bytesToString();
    return res.statusCode == 201 ? content : content;
  }
}
