// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tutor_app/main.dart';
import 'package:json_theme/json_theme.dart';
import 'package:flutter/services.dart'; // For rootBundle
import 'dart:convert';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    WidgetsFlutterBinding.ensureInitialized();

    final themeStrDark =
        await rootBundle.loadString('assets/appainter_theme_dark.json');
    final themeJsonDark = jsonDecode(themeStrDark);
    final themeDark = ThemeDecoder.decodeThemeData(themeJsonDark)!;

    final themeStrLight =
        await rootBundle.loadString('assets/appainter_theme_light.json');
    final themeJsonLight = jsonDecode(themeStrLight);
    final themeLight = ThemeDecoder.decodeThemeData(themeJsonLight)!;

    // Build our app and trigger a frame.
    await tester
        .pumpWidget(MyApp(theme_dark: themeDark, theme_light: themeLight));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
