import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/auth/supabase_auth/auth_util.dart';

dynamic saveChatHistory(
  dynamic chatHistory,
  dynamic newChat,
) {
  // If chatHistory isn't a list, make it a list and then add newChat
  if (chatHistory is List) {
    chatHistory.add(newChat);
    return chatHistory;
  } else {
    return [newChat];
  }
}

List<String> convertToStringList(String text) {
  return [text];
}

bool? showSearchResult(
  String textSearchFor,
  String textSearchIn,
) {
  return textSearchIn.toLowerCase().contains(textSearchFor.toLowerCase());
}

String convertListtoString(List<String> text) {
  return text.join();
}

double doubleDivision(
  int lessonsCompleted,
  int totalLessons,
) {
  if (totalLessons == 0) return 0;
  return lessonsCompleted / totalLessons;
}

double coursePercantage(
  int lessonsCompleted,
  int totalLessons,
) {
  if (totalLessons == 0) return 0;
  return lessonsCompleted / totalLessons;
}

int? nMinusOne(int nValue) {
  if (nValue == 0) return 0;
  return nValue - 1;
}

int? lastListOfMessages(List<MessageStruct> listOfMessages) {
  if (listOfMessages.isEmpty) return null;
  return listOfMessages.length - 1;
}

int calculateTotalReached(List<int>? listofReached) {
  if (listofReached == null || listofReached.isEmpty) {
    return 0;
  }
  return listofReached.reduce((a, b) => a + b);
}

int totalXP(
  int courseXP,
  int lessonXP,
) {
  return courseXP + lessonXP;
}

dynamic convertTextToJSON(String text) {
  try {
    final decoded = json.decode(text);

    // Ensure it's JSON-serializable and return it as a string
    return json.encode(decoded);
  } catch (e) {
    print("JSON parse error: $e");
    return null;
  }
}
