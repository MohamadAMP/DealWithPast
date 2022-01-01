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

  // upload() async {
  //   Dio dio = Dio();
  //   FormData formdata = FormData();
  //   // File file = File(
  //   //     'C:/Users/Mohamad/Desktop/Doha Dictionary App/doha_dict_app/assets/Images/Design/logoNoLettering.png');
  //   // print(await file.length());
  //   ByteData imageBytes = await rootBundle.load('assets/google_logo.png');
  //   formdata = FormData.fromMap({
  //     'file': await MultipartFile.fromBytes(imageBytes.buffer.asUint8List(),
  //         filename: 'image', contentType: MediaType("image", "png"))
  //   });

  //   dio
  //       .post("https://dwp.world/wp-json/wp/v2/media",
  //           data: formdata,
  //           options: Options(
  //             method: 'POST',
  //             headers: {
  //               'Content-Type': 'image/png',
  //               'Authorization':
  //                   'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZHdwLndvcmxkIiwiaWF0IjoxNjM5ODM3MjQyLCJuYmYiOjE2Mzk4MzcyNDIsImV4cCI6MTY0MDQ0MjA0MiwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiNyJ9fX0.AZjk_lZNuDbjZz9i5cmiBhqyzyW02L75xSbINBrwfWE',
  //             },
  //             // responseType: ResponseType.json // or ResponseType.JSON
  //           ))
  //       .then((response) => print(response))
  //       .catchError((error) => print(error));
  // }

  // upload() async {
  //   Map<String, String> requestHeaders = {
  //     'Authorization':
  //         'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZHdwLndvcmxkIiwiaWF0IjoxNjM5ODM3MjQyLCJuYmYiOjE2Mzk4MzcyNDIsImV4cCI6MTY0MDQ0MjA0MiwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiNyJ9fX0.AZjk_lZNuDbjZz9i5cmiBhqyzyW02L75xSbINBrwfWE',
  //     'Content-Type': 'image/png'
  //   };

  //   ByteData imgBytes = await rootBundle.load('assets/google_logo.png');
  //   List<int> imageBytes = imgBytes.buffer.asUint8List();
  //   var request = http.Request(
  //       'POST', Uri.parse('https://dwp.world/wp-json/wp/v2/media'));
  //   request.headers.addAll(requestHeaders);
  //   request.bodyBytes = imageBytes;
  //   var res = await request.send().catchError((error) => print(error));

  //   return res.statusCode == 400
  //       ? print(res.reasonPhrase)
  //       : print(res.statusCode);
  // }