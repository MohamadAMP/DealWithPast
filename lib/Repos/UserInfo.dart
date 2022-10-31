// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
// import 'package:alt_http/alt_http.dart';
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
//     var client = AltHttpClient();

//     HttpClientRequest request = await client.postUrl(Uri.parse(
//         "http://dwp.world/wp-json/wp/v2/users?search=ronisayegh@hotmail.com"));
// request.abort();
//     HttpClientResponse response = await request.close();
//     final stringData = await response.transform(utf8.decoder).join();
//     print(stringData);
    final response = await http.get(
        Uri.parse('http://dwp.world/wp-json/wp/v2/users?search=' + email),
        headers: {
          "connection": "keep-alive",
          'content-type': 'application/json',
          'accept': 'application/json',
          'authorization': 'Bearer $token',
        });

    List<UserData> userInfo = [];
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var temp = data.isEmpty;
      print(temp);
      if (temp) {
        return 0;
      } else {
        var user = UserData.fromJson(data[0]);

        userInfo.add(user);

        return userInfo;
      }
    }
  }
}
