import 'package:demo/core/utilty/duration_items.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, DurationItem duration) {
  final snackBar = SnackBar(
    duration: duration.str(),
    content: Text(message),
    // action: SnackBarAction(
    //   label: '!',
    //   onPressed: () {
    //     // Some code to undo the change.
    //   },
    // ),
  );
  // ignore: use_build_context_synchronously
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
