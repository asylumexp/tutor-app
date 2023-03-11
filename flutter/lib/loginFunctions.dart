import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

Future<http.Response> requestLogin(String email, String pass) {
  try {
    return http.post(
      Uri.parse('http://localhost:9000/api/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': pass}),
    );
  } catch (e) {
    log("exception at sign in");
    rethrow;
  }
}
