import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<String> login() async {
  await supabase.auth.signInWithOAuth(
    Provider.google,
    redirectTo: kIsWeb ? null : 'tutorapp://localhost/',
  );

  return '';
}
