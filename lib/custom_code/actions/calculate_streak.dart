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

import 'package:streak_calculator/streak_calculator.dart';

Future<List<dynamic>> calculateStreak(
  List<DateTime> eventDates,
  int previousStreak,
) async {
  // Normalize to local days
  final localDaySet = <DateTime>{};
  for (final dt in eventDates) {
    final local = dt.toLocal();
    localDaySet.add(DateTime(local.year, local.month, local.day));
  }

  // Current week Mon–Sun
  final nowLocal = DateTime.now().toLocal();
  final int deltaToMonday = nowLocal.weekday - DateTime.monday;
  final weekStartMonday = DateTime(nowLocal.year, nowLocal.month, nowLocal.day)
      .subtract(Duration(days: deltaToMonday));

  final weekDays = List<DateTime>.generate(
    7,
    (i) => DateTime(
      weekStartMonday.year,
      weekStartMonday.month,
      weekStartMonday.day + i,
    ),
  );

  const labels = {
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };

// Build the list locally first
  final activeDayLabels = <String>[];
  for (final d in weekDays) {
    if (localDaySet.contains(d)) {
      activeDayLabels.add(labels[d.weekday]!);
    }
  }

// Write once inside update() so FFAppState persistence/notification runs once
  FFAppState().update(() {
    FFAppState().activeDays = List.from(activeDayLabels);
  });

  final streakCalc = StreakCalculator(
    dates: eventDates.map((e) => e.toLocal()).toList(),
    streakType: StreakType.daily,
  );

  final currentStreak = streakCalc.currentStreak;
  final isStreak = currentStreak > previousStreak;

  // ✅ Return Map instead of List
  return [
    {'active_days': activeDayLabels},
    {'streak': currentStreak},
    {'is_streak': isStreak},
  ];
}
