// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:postgrest/postgrest.dart' as postgrest;
import 'package:share_plus/share_plus.dart';

Future shareFile(BuildContext context, String url) async {
  try {
    var fileType = getFileTypeFromUrl(url);
    var directory = await getTemporaryDirectory();
    var fileName = DateTime.now().millisecondsSinceEpoch;
    var filePath = '${directory.path}/$fileName.$fileType';
    dio.Dio dioClient = dio.Dio();

    await dioClient.download(url, (dio.Headers headers) {
      filePath = '${directory.path}/$fileName.$fileType';
      return filePath;
    }).then((response) async {
      if (response.statusCode == 200) {
        await Share.shareXFiles([XFile(filePath)]);
      }
    });
  } catch (e) {
    print(e);
  }
}

String getFileTypeFromUrl(String url) {
  try {
    String fileName = url.split('?')[0];

    // Extract the file extension (everything after the last dot in the filename)
    String fileType = fileName.split('.').last;
    return fileType.toUpperCase();
  } catch (e) {
    return "";
  }
}
