import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tutor_app/login_page.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uni_links_desktop/uni_links_desktop.dart';
import 'styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This registers the tutorapp:// url scheme
  if (Platform.isWindows) {
    registerProtocol('tutorapp');
  }

  await Supabase.initialize(
    url: 'https://vuftofhyjjdqswtnuohg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ1ZnRvZmh5ampkcXN3dG51b2hnIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODczMDY1NTMsImV4cCI6MjAwMjg4MjU1M30.AIT7TFp6BZsawX-6wwyUtsY1kEG2ZYlvaWJ_iKR85mQ',
  );

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
      home: const LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
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
            Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.2,
                    vertical: 20)),
            createButton(
                label: 'go to logogogin',
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation1,
                              Animation<double> animation2) {
                            return const LoginPage();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero));
                }),
            createButton(
                label: 'Sign out',
                onPressed: () {
                  final supabase = Supabase.instance.client;
                  supabase.auth.signOut();
                }),
            createButton(
                label: 'quit',
                onPressed: () {
                  exit(0);
                })
          ],
        ),
      ),
    );
  }
}
