import 'package:flutter/material.dart';

//! reusable widget
class ShowsnackBarUtiltiy {
  static showSnackbar(
      {required String message, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Color.fromARGB(221, 16, 20, 14)),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21),
          ),
          backgroundColor: const Color.fromARGB(255, 117, 238, 80)),
    );
  }
}
