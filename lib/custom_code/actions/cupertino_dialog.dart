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

Future cupertinoDialog(
  BuildContext context,
  Color btnColor,
) async {
  // Function to show an information dialog or alert dialog
  showDialogInfo() {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          false, // Disallows dismissing the dialog by tapping outside it
      builder: (BuildContext context) {
        final textTheme = Theme.of(context)
            .textTheme
            .apply(displayColor: Theme.of(context).colorScheme.onSurface);

        return CupertinoAlertDialog(
          // Dialog title with formatted text
          title: Text('Convert or Seed?',
              style: textTheme.titleMedium!
                  .copyWith(letterSpacing: 0.1, fontWeight: FontWeight.w600)),
          // Dialog content with formatted text
          content: Text(
              "By \"convert,\" we are referring to someone who said Yes to Jesus, i.e., they accepted Jesus as their Lord and Savior.\n\nBy \"seed,\" we are referring to someone with whom you shared your faith but didn't give their life to Jesus. But it is not a loss, as the Bible tells us that some plant and some water, but God brings the increase (1 Cor 3:6-7).",
              style: textTheme.bodyMedium!),
          actions: <Widget>[
            // Button to continue with formatted text
            CupertinoDialogAction(
              child: Text('Okay',
                  style: textTheme.titleMedium!
                      .copyWith(color: btnColor, letterSpacing: 0.3)),
              onPressed: () {
                Navigator.of(context).pop(); // Dismisses the dialog
              },
            ),
          ],
        );
      },
    );
  }

  showDialogInfo();
}
