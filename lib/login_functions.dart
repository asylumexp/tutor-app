import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String> login() async {
  await supabase.auth.signInWithOAuth(
    Provider.google,
    // Checks that this isnt web, if it isnt them redirect to tutorapp URL
    redirectTo: kIsWeb ? null : 'tutorapp://localhost/',
  );
  supabase.auth.onAuthStateChange.listen((data) async {
    final AuthChangeEvent event = data.event;
    if (event == AuthChangeEvent.signedIn) {
      sleep(const Duration(seconds: 2));
      await supabase
          .from("tutor")
          .select()
          .eq("userid", supabase.auth.currentUser!.id)
          .then((res) async {
        print(res);
        if (res.toString() == "[]") {
          await supabase.from("tutor").insert({
            "first_name": "Test",
            "last_name": "test",
            "email": supabase.auth.currentUser!.email,
            "subjects": ["None"],
            "students": ["None"],
            "userid": supabase.auth.currentUser!.id
          });
        }
      });
    }
  });

  return '';
}
