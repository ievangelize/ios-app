import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
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

int? lastListOfMessages(List listOfMessages) {
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

bool isIntEven(int number) {
  if (number == 0) {
    return false; // 0 is negligible per your requirement
  }

  return number % 2 == 0;
}

List<dynamic> buildCumulativeEncounterTrend(
  DateTime startDate,
  List<DateTime> encounterDates,
  List<int> reachedCounts,
) {
  DateTime today = DateTime.now();

  // Normalize start and today to remove time portion
  DateTime start = DateTime(startDate.year, startDate.month, startDate.day);
  DateTime end = DateTime(today.year, today.month, today.day);

  int totalDays = end.difference(start).inDays + 1;

  List<double> xValues = [];
  List<double> yValues = [];

  double cumulativeTotal = 0;

  for (int i = 0; i < totalDays; i++) {
    DateTime currentDay = start.add(Duration(days: i));

    // Sum all encounters for this day
    for (int j = 0; j < encounterDates.length; j++) {
      DateTime encounterDay = DateTime(
        encounterDates[j].year,
        encounterDates[j].month,
        encounterDates[j].day,
      );

      if (encounterDay == currentDay) {
        cumulativeTotal += reachedCounts[j].toDouble();
      }
    }

    xValues.add(i.toDouble()); // Day index
    yValues.add(cumulativeTotal); // Running total
  }

  return [xValues, yValues];
}

int friendsLeft(int friendsCount) {
  if (friendsCount == 12) return 0;
  return 12 - friendsCount;
}
