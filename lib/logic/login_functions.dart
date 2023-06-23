import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import '../views/register_page.dart';

final supabase = Supabase.instance.client;

/// Supabase google login.
///
/// Signs in with google oauth, then checks if the user is new.
/// Requires for the BuildContext to be passed.
Future<void> login(BuildContext buildContext) async {
  if (supabase.auth.currentUser == null) {
    await supabase.auth.signInWithOAuth(
      Provider.google,
      // Checks that this isnt web, if it isnt them redirect to tutorapp URL
      redirectTo: kIsWeb ? null : 'tutorapp://localhost/',
    );
  }

  supabase.auth.onAuthStateChange.listen((data) async {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      await supabase
          .from("tutor")
          .select()
          .eq("userid", supabase.auth.currentUser!.id)
          .then((res) async {
        // If the user is new, then move to register page
        if (res.toString() == "[]") {
          Navigator.push(
              buildContext,
              PageRouteBuilder(
                  pageBuilder: (BuildContext context,
                      Animation<double> animation1,
                      Animation<double> animation2) {
                    return const RegisterPage();
                  },
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero));
        }
      });
    }
  });
}

bool isUserSignedIn() {
  final session = supabase.auth.currentSession;
  return session != null;
}
