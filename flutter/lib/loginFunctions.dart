import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutor_app/login_page.dart';

Future<http.Response> requestRegister(String user, String email, String pass) {
  try {
    return http.post(
      Uri.parse('http://localhost:9000/api/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'username': user, 'email': email, 'password': pass}),
    );
  } catch (e) {
    log("exception at sign up");
    rethrow;
  }
}

Future<String> requestLogin(String email, String pass) async {
  var errors = [];
  try {
    final res = await http.post(
      Uri.parse('http://localhost:9000/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': pass}),
    );
    switch (res.statusCode) {
      case 200:
        log("success");
        break;
      case 400:
        errors.add("bad pass");
        break;
      case 404:
        errors.add("bad user");
        break;
      case 555:
        List<String> list = res.body
            .toString()
            .replaceAll("},{", "|")
            .replaceAll(RegExp(r'[\[\]{}]+'), "")
            .split("|");

        for (final e in list) {
          List<String> currList = e.split(",");
          switch (currList[2]) {
            case '"param":"password"':
              errors.add("password is officially bad");
              break;
            case '"param":"email"':
              errors.add("email is officially bad");
              break;
          }
        }
        break;
    }
  } catch (e) {
    log("exception at signin");
  }
  return errors.toString();
}

void parseLogin(http.Response response) {
  if (response.statusCode == 200) {
    var jsonObj = jsonDecode(response.body);
    addStringToSF('userId', jsonObj["userId"]);
    getValue("userId");
  }
}

void addStringToSF(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.get(key));
}
