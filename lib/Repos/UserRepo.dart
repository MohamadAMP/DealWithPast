// ignore_for_file: avoid_print, file_names, non_constant_identifier_names
import 'dart:convert';

import 'package:http/http.dart' as http;

String Token = "";

class UserRepo {
  Login(String uid, String email, String username) async {
    // var userName = username.split(" ").join(" ");
    final response = await http.post(
      Uri.parse('http://dwp.world/wp-json/wp/v2/users/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': uid,
        'role': 'contributor'
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Token = data["token"];
      // print(data);
      return true;
    } else {
      print(response.body);
      return false;
    }
  }

  Authenticate(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dwp.world/wp-json/jwt-auth/v1/token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': "admin", 'password': "admin_1234"}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var token = data['token'];
      print(token);
      return token;
    } else {
      print(response.body);
      return false;
    }
  }

  AuthenticateOther(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dwp.world/wp-json/jwt-auth/v1/token'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var token = data['token'];
      print(token);
      return token;
    } else {
      print(response.body);
      return false;
    }
  }
}
