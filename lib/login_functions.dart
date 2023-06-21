// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';

// Future<List<dynamic>> requestRegister(
//     String user, String email, String pass, bool tutor) async {
//   try {
//     final credential =
//         await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: pass,
//     );
//     String? uid = credential.user?.uid.toString();

//     DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
//     await ref.set({"username": user, "tutor": tutor.toString()});
//     return ["success", credential.user?.uid.toString()];
//   } on FirebaseAuthException catch (e) {
//     return codeToUser(e.code);
//   }
// }

// Future<List<dynamic>> requestLogin(String email, String pass) async {
//   try {
//     final credential = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: pass);
//     String? uid = credential.user?.uid.toString();

//     DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid/');
//     var snapshot = await ref.once();
//     return [
//       "success",
//       [credential.user?.uid.toString(), snapshot.snapshot.value as Map]
//     ];
//   } on FirebaseAuthException catch (e) {
//     final code = codeToUser(e.code);
//     return code;
//   }
// }

// void parseLogin(http.Response response) {
//   if (response.statusCode == 200) {
//     var jsonObj = jsonDecode(response.body);
//     addStringToSF('userId', jsonObj["userId"]);
//     getValue("userId");
//   }
// }

// Future<Object> addStringToSF(String key, String value) async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, value);
//     return Object;
//   } catch (e) {
//     return e;
//   }
// }

// void getValue(String key) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   log(prefs.get(key).toString());
// }

// List<String> codeToUser(String code) {
//   switch (code) {
//     case "invalid-email":
//       return ["email", "This email is invalid."];
//     case "user-disabled":
//       return ["email", "This user is disabled."];
//     case "user-not-found":
//       return ["email", "No user was found from this email."];
//     case "wrong-password":
//       return ["password", "This password is invalid."];
//     case "email-already-in-use":
//       return ["email", "This email is already in use."];
//     case "weak-password":
//       return ["password", "This password is not strong enough."];
//     default:
//       print(code);
//       return ["email", "An internal server error occurred."];
//   }
// }
