import 'package:flutter/material.dart';

/// Returns a button widget.
///
/// [label] is the text for the default text button, [action] being the
/// onPressed action, [height] and [width] being the dimensions of the box,
/// [decoration] is the styling for the container, and [child] is the child
/// of the container. Returns the newly created button.
Container createButton(
    {required String label,
    required Function action,
    double? height,
    double? width,
    BoxDecoration? decoration,
    TextButton? child}) {
  return Container(
    height: height ?? 50,
    width: width ?? 250,
    decoration: decoration ??
        BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
    child: child ??
        TextButton(
          onPressed: () => action(),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
  );
}
