// ignore_for_file: file_names, avoid_print, unused_import

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:interactive_map/Repos/UserRepo.dart';
import 'StoryClass.dart';

class StoryRepo {
  getStories(token) async {
    final response = await http.get(
        Uri.parse('http://dwp.world/wp-json/wp/v2/stories/?per_page=100'),
        headers: {
          "connection": "keep-alive",
          'Authorization': 'Bearer $token',
        });
    int x = int.parse(response.headers['x-wp-totalpages']!);

    List<Story> stories = [];
    for (int i = 0; i < x; i++) {
      final response = await http.get(
          Uri.parse(
              'http://dwp.world/wp-json/wp/v2/stories/?per_page=100&page=' +
                  (i + 1).toString()),
          headers: {
            "connection": "keep-alive",
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data.forEach((e) {
          if (e['acf']['event_date'] != '' &&
              e['acf']['map_location'] != false) {
            stories.add(Story.fromJson(e));
          }
        });
      }
    }
    print(stories.length);
    return stories;
  }

  // getStoriesTimeline(token) async {
  //   final response = await http.get(
  //       Uri.parse('http://dwp.world/wp-json/wp/v2/stories/?per_page=100'),
  //       headers: {
  //         "connection": "keep-alive",
  //         'Authorization': 'Bearer $token',
  //       });
  //   int x = int.parse(response.headers['x-wp-totalpages']!);

  //   List<Story> stories = [];
  //   for (int i = 0; i < x; i++) {
  //     final response = await http.get(
  //         Uri.parse(
  //             'http://dwp.world/wp-json/wp/v2/stories/?per_page=100&page=' +
  //                 (i + 1).toString()),
  //         headers: {
  //           "connection": "keep-alive",
  //           'Authorization': 'Bearer $token',
  //         });
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(response.body);
  //       data.forEach((e) {
  //         if (e['acf']['event_date'] != '' &&
  //             e['acf']['map_location'] != false) {
  //           if (e['better_featured_image']['description'] != '') {
  //             stories.add(Story.fromJson(e));
  //           } else if (e['acf']['gallery'] != false) {
  //             var gallery = e['acf']['gallery'];
  //             gallery.forEach((q) {
  //               print(q['mime_type']);
  //               if (q['type'] == 'video') {
  //                 stories.add(Story.fromJson(e));
  //               }
  //             });
  //           }
  //         }
  //       });
  //     }
  //   }
  //   print(stories.length);
  //   return stories;
  // }

  getStoriesByAuthor(id, token) async {
    final response = await http.get(
        Uri.parse('http://dwp.world/wp-json/wp/v2/stories/?per_page=100'),
        headers: {
          "connection": "keep-alive",
          'Authorization': 'Bearer $token',
        });

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e) {
        if (e['acf']['event_date'] != '' && e['acf']['map_location'] != false) {
          var story = Story.fromJson(e);
          if (story.author == id) {
            stories.add(story);
          }
        }
      });
      return stories;
    } else {
      return false;
    }
  }

  getStoriesPendingByAuthor(id, token) async {
    final response = await http.get(
        Uri.parse(
            'https://dwp.world/wp-json/wp/v2/stories/?per_page=100&status=pending'),
        headers: {
          "connection": "keep-alive",
          'Authorization': 'Bearer $token',
        });

    List<Story> stories = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      data.forEach((e) {
        if (e['acf']['event_date'] != '' && e['acf']['map_location'] != false) {
          var story = Story.fromJson(e);
          if (story.author == id) {
            stories.add(story);
            print(story.event_date);
          }
        }
      });
      return stories;
    } else {
      return false;
    }
  }

  postStory(data, username, password) async {
    UserRepo userRepo = UserRepo();
    var token = await userRepo.AuthenticateOther(username, password);

    String url = 'https://dwp.world/wp-json/wp/v2/stories/';

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
    return content;
  }
}
