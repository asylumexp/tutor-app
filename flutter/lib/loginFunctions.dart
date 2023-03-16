import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<http.Response> requestRegister(String user, String email, String pass) {
  try {
    return http.post(
      Uri.parse(
          'https://9000-samh06-tutorapp-rfd447s5uk7.ws-us90.gitpod.io/api/auth/register'),
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

void requestLogin(String email, String pass) async {
  try {
    final res = await http.post(
      Uri.parse(
          'https://9000-samh06-tutorapp-rfd447s5uk7.ws-us90.gitpod.io/api/auth/login'),
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
        log("bad pass");
        break;
      case 404:
        log("bad user");
        break;
    }
  } catch (e) {
    print("exception at sign in");
    rethrow;
  }
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
