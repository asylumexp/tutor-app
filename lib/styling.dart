import 'package:flutter/material.dart';

Widget createButton(
    {required String label,
    required Function onPressed,
    double? height,
    double? width,
    BoxDecoration? decoration,
    TextButton? textButton}) {
  return Container(
    height: height ?? 50,
    width: width ?? 250,
    decoration: decoration ??
        BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
    child: textButton ??
        TextButton(
          onPressed: () => onPressed(),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
  );
}
