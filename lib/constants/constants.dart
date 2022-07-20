import 'package:flutter/material.dart';

class Constants {
  static ButtonStyle kElevatedButtonStyle = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    primary: Colors.black87,
    padding: const EdgeInsets.symmetric(horizontal: 16),
  );
}
