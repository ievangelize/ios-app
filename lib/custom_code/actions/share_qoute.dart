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

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as dio;
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

    // Add headers in case the URL requires auth or specific content negotiation
    final response = await dioClient.download(
      url,
      filePath,
      options: dio.Options(
        headers: {
          'Accept': '*/*',
        },
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );

    if (response.statusCode == 200) {
      final file = File(filePath);
      if (await file.exists()) {
        // Get the render box for share position (required on iPad, safe on all)
        final box = context.findRenderObject() as RenderBox?;
        final sharePositionOrigin = box != null
            ? box.localToGlobal(Offset.zero) & box.size
            : Rect.fromLTWH(0, 0, 100, 100); // fallback rect

        await Share.shareXFiles(
          [XFile(filePath, mimeType: _getMimeType(fileType))],
          sharePositionOrigin: sharePositionOrigin,
        );
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
    return '';
  }
}

String _getMimeType(String fileType) {
  switch (fileType) {
    case 'jpg':
    case 'jpeg':
      return 'image/jpeg';
    case 'png':
      return 'image/png';
    case 'gif':
      return 'image/gif';
    case 'webp':
      return 'image/webp';
    case 'mp4':
      return 'video/mp4';
    case 'pdf':
      return 'application/pdf';
    default:
      return 'application/octet-stream';
  }
}
