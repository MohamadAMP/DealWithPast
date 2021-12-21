// ignore_for_file: file_names, avoid_print, unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_map/Repos/UserRepo.dart';
import 'StoryClass.dart';

class StoryRepo {
  getStories(token) async {
    final response = await http
        .get(Uri.parse('http://dwp.world/wp-json/wp/v2/stories'), headers: {
      "connection": "keep-alive",
      'Authorization': 'Bearer $token',
    });

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e) {
        print(e['author']);
        stories.add(Story.fromJson(e));
      });
      return stories;
    } else {
      print(response.statusCode);
      return [];
    }
  }

  getStoriesByAuthor(id, token) async {
    final response = await http
        .get(Uri.parse('http://dwp.world/wp-json/wp/v2/stories'), headers: {
      "connection": "keep-alive",
      'Authorization': 'Bearer $token',
    });

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e) {
        var story = Story.fromJson(e);
        if (story.author == id) {
          stories.add(story);
        }
      });
      return stories;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  getStoriesPendingByAuthor(id, token) async {
    final response = await http.get(
        Uri.parse('https://dwp.world/wp-json/wp/v2/stories/?status=pending'),
        headers: {
          "connection": "keep-alive",
          'Authorization': 'Bearer $token',
        });

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e) {
        var story = Story.fromJson(e);
        if (story.author == id) {
          stories.add(story);
        }
      });
      return stories;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  postStory(data, username, password) async {
    print(username);
    print(password);
    UserRepo userRepo = UserRepo();
    var token = await userRepo.AuthenticateOther(username, password);
    print(token);

    String url = 'https://dwp.world/wp-json/wp/v2/stories';

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('POST', Uri.parse(url));
    request.headers.addAll(requestHeaders);
    request.body = jsonEncode(data);
    var res = await request.send();
    var content = await res.stream.bytesToString();
    print(jsonDecode(content)['anonymous']);

    return content;
  }
}
