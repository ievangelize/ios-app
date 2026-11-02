// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future initPushNavigationHandler(BuildContext context) async {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  // 🔹 1. Handle app opened from terminated state
  RemoteMessage? initialMessage = await messaging.getInitialMessage();

  if (initialMessage != null) {
    _handleNavigation(context, initialMessage);
  }

  // 🔹 2. Handle app opened from background
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    _handleNavigation(context, message);
  });
}

// 🔥 Central router
void _handleNavigation(BuildContext context, RemoteMessage message) {
  final page = message.data['page'];

  if (page == null) return;

  context.goNamed(page);
}
