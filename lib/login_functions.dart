import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<dynamic> requestRegister(String user, String email, String pass) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        log(user.uid);
      }
    });
  } on FirebaseAuthException catch (e) {
    log(e.code);
    return e.code;
  } catch (e) {
    log(e.toString());
    return e;
  }
}

Future<List<dynamic>> requestLogin(String email, String pass) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    return ["success", credential.user?.uid.toString()];
  } on FirebaseAuthException catch (e) {
    final code = codeToUser(e.code);
    return code;
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

void getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log(prefs.get(key).toString());
}

List<String> codeToUser(String code) {
  switch (code) {
    case "invalid-email":
      return ["email", "This email is invalid."];
    case "user-disabled":
      return ["email", "This user is disabled."];
    case "user-not-found":
      return ["email", "No user was found from this email."];
    case "wrong-password":
      return ["password", "This password is invalid."];
    default:
      return ["email", "An internal server error occurred."];
  }
}
