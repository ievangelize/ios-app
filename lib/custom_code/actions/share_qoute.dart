// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:postgrest/postgrest.dart' as postgrest;
import 'package:share_plus/share_plus.dart';
import 'package:cross_file/cross_file.dart';

Future shareQoute(BuildContext context, String url) async {
  try {
    final fileType = getFileTypeFromUrl(url);
    final directory = await getTemporaryDirectory();
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final filePath =
        '${directory.path}/$fileName.${fileType.isNotEmpty ? fileType : 'bin'}';

    final dio.Dio dioClient = dio.Dio();

    final response = await dioClient.download(
      url,
      filePath,
    );

    if (response.statusCode == 200) {
      final file = File(filePath);
      if (await file.exists()) {
        await Share.shareXFiles([XFile(filePath)]);
      } else {
        debugPrint('shareQuote: file not found at $filePath');
      }
    } else {
      debugPrint('shareQuote: download failed: ${response.statusCode}');
    }
  } catch (e, st) {
    debugPrint('shareQuote error: $e\n$st');
  }
}

String getFileTypeFromUrl(String url) {
  try {
    final fileName = url.split('?')[0];
    final type = fileName.split('.').last;
    return type.toLowerCase();
  } catch (e) {
    return "";
  }
}
