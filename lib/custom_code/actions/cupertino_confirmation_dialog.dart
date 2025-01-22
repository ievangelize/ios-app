// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/cupertino.dart';

Future<bool> cupertinoConfirmationDialog(
  BuildContext context,
  String titleText,
  String contentText,
  String leftBtn,
  String rightBtn,
  Color rightBtnColor,
  Color leftBtnColor,
) async {
  // Create a new text theme that applies the display color to the text
  final textTheme = Theme.of(context)
      .textTheme
      .apply(displayColor: Theme.of(context).colorScheme.onSurface);

  // Show a Cupertino-style dialog box
  final result = await showCupertinoDialog<bool>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      // Add a title to the dialog with the 'Logout?' text, using the textTheme to apply styles
      title: Text(
        titleText,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      // Add content to the dialog with the 'Are you sure want to logout?' text, using the textTheme to apply styles
      content: Text(
        contentText,
        style: textTheme.bodyMedium!,
      ),
      // Add two actions to the dialog: Cancel and Logout
      actions: [
        CupertinoDialogAction(
          child: Text(
            leftBtn,
            style: textTheme.titleMedium!.copyWith(
              color: leftBtnColor,
            ),
          ),
          onPressed: () {
            // Handle the 'Cancel' action by dismissing the dialog
            Navigator.of(context).pop(false); // return false for cancel
          },
        ),
        CupertinoDialogAction(
          child: Text(
            rightBtn,
            style: textTheme.titleMedium!.copyWith(
              color: rightBtnColor,
            ),
          ),
          onPressed: () {
            // Handle the 'Logout' action by dismissing the dialog
            Navigator.of(context).pop(true); // return true for logout
          },
        ),
      ],
    ),
  );

  // Return the result from the dialog
  return result ?? false; // If result is null, return false
}
