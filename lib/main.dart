import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tutor_app/login_page.dart';
import 'register_page.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print(e);
  }

  final themeStrDark =
      await rootBundle.loadString('assets/appainter_theme_dark.json');
  final themeJsonDark = jsonDecode(themeStrDark);
  final loadedthemeDark = ThemeDecoder.decodeThemeData(themeJsonDark)!;
  final themeStrLight =
      await rootBundle.loadString('assets/appainter_theme_light.json');
  final themeJsonLight = jsonDecode(themeStrLight);
  final loadedthemeLight = ThemeDecoder.decodeThemeData(themeJsonLight)!;

  runApp(MyApp(themeLight: loadedthemeLight, themeDark: loadedthemeDark));
}

class MyApp extends StatelessWidget {
  final ThemeData themeDark;
  final ThemeData themeLight;

  const MyApp({Key? key, required this.themeDark, required this.themeLight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      darkTheme: themeDark,
      themeMode: ThemeMode.system,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

// Define a custom Form widget.

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return RegisterPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero));
                },
                child: const Text(
                  'go to reggisters',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2,
                    vertical: 20)),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return loginPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero));
                },
                child: const Text(
                  'go to logogogin',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text(
                  'quit',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
