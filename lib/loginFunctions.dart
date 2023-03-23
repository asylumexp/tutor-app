import 'dart:developer';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<dynamic> requestRegister(String user, String email, String pass) async {
  try {
    final creds = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pass,
    );
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
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

Future<dynamic> requestLogin(String email, String pass) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
    print(credential.user!.uid);
  } on FirebaseAuthException catch (e) {
    print(e.code);
    return e.code;
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
