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

Future<List> requestLogin(String email, String pass) async {
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
        errors.add(["password", "bad pass"]);
        break;
      case 422:
        errors.add(["email", "bad user"]);
        break;
      case 555:
        List<String> list = res.body
            .toString()
            .replaceAll("},{", "|")
            .replaceAll(RegExp(r'[\[\]{}]+'), "")
            .split("|");

        for (final e in list) {
          List currList = e.split(",");
          switch (currList[1]) {
            case '"msg":"password"':
              errors.add(
                  ["password", currList[2].toString().replaceAll('"', "")]);
              break;
            case '"msg":"email"':
              errors.add(["email", currList[2].toString().replaceAll('"', "")]);
              break;
          }
        }
        break;
    }
  } catch (e) {
    log("exception at signin");
  }
  return errors;
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
