import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration greyRounded({
    String? hintText,
    double verticalPadding = 10,
    double horizontalPadding = 16,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: const Color.fromARGB(255, 158, 158, 158)),
      filled: true,
      fillColor: const Color.fromARGB(255, 244, 244, 244),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
    );
  }
}
