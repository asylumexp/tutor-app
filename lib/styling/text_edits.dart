import 'package:flutter/material.dart';

TextField createTextField(
    {required TextEditingController controller,
    required String labelText,
    String? errorMessages,
    bool? obscureText}) {
  return TextField(
    controller: controller,
    obscureText: obscureText ?? false,
    textAlign: TextAlign.start,
    maxLines: 1,
    style: const TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 16,
      // color: Color(0xff000000),
    ),
    decoration: InputDecoration(
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide:
            const BorderSide(color: Color.fromARGB(255, 255, 0, 0), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Color(0xff9e9e9e), width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: Color(0xff9e9e9e), width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide:
            const BorderSide(color: Color.fromARGB(123, 255, 0, 0), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide:
            const BorderSide(color: Color.fromARGB(123, 255, 0, 0), width: 1),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        // color: Color(0xff9e9e9e),
      ),
      filled: true,
      fillColor: const Color(0x00f2f2f3),
      isDense: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      errorText: errorMessages,
    ),
  );
}
