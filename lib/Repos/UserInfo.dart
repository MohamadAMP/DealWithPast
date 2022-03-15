// ignore_for_file: file_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'UserClass.dart';

class UserInfoRepo {
  getUserInfo(id, token) async {
    // UserRepo userRepo = UserRepo();
    // var tok = await userRepo.Authenticate("admin", "admin_1234");
    String url = 'http://dwp.world/wp-json/wp/v2/users/' +
        id.toString() +
        "/?per_page=100";
    final response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    List<UserData> userInfo = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      userInfo.add(UserData.fromJson(data));
      return userInfo;
    } else {
      return false;
    }
  }

  getUserInfoByEmail(email, token) async {
    final response = await http.get(
        Uri.parse('http://dwp.world/wp-json/wp/v2/users/?per_page=100'),
        headers: {
          "connection": "keep-alive",
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    int x = int.parse(response.headers['x-wp-totalpages']!);

    List<UserData> userInfo = [];
    for (int i = 0; i < x; i++) {
      final response = await http.get(
          Uri.parse('http://dwp.world/wp-json/wp/v2/users/?per_page=100&page=' +
              (i + 1).toString()),
          headers: {
            "connection": "keep-alive",
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          });
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        data.forEach((e) {
          var user = UserData.fromJson(e);
          if (user.name == email) {
            userInfo.add(user);
          }
        });
      }
    }
    return userInfo;
  }
}
