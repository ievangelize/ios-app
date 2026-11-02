import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/components/streak/streak_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';

Future sendFriendNotification(
  BuildContext context, {
  required String? eventType,
  String? prayerTargetName,
}) async {
  List<FriendsRow>? friends;
  List<UsersRow>? user;
  ApiCallResponse? apicall1;
  ApiCallResponse? apicall2;
  ApiCallResponse? apicall4;
  ApiCallResponse? apicall5;
  ApiCallResponse? apicall6;
  ApiCallResponse? apicall3;

  friends = await FriendsTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'user_id',
      currentUserUid,
    ),
  );
  user = await UsersTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'id',
      currentUserUid,
    ),
  );
  if (eventType == 'course complete') {
    apicall1 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Friend\'s Activity',
      body: '${user.firstOrNull?.fullName} just completed a course! 💯',
    );

    if ((apicall1.succeeded ?? true)) {
      return;
    }

    return;
  } else if (eventType == 'mission complete') {
    apicall2 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Friend\'s Activity',
      body: '${user.firstOrNull?.fullName} just completed a mission! 🎯',
    );

    if ((apicall2.succeeded ?? true)) {
      return;
    }

    return;
  } else if (eventType == 'target update') {
    apicall4 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Friend\'s Activity',
      body:
          '${user.firstOrNull?.fullName} added a Prayer List update to ${prayerTargetName}',
    );

    if ((apicall4.succeeded ?? true)) {
      return;
    }

    return;
  } else if (eventType == 'target saved') {
    apicall5 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Great News!🥳',
      body:
          '${prayerTargetName}, from ${user.firstOrNull?.fullName}\'s Prayet List accepted Christ!',
    );

    if ((apicall5.succeeded ?? true)) {
      return;
    }

    return;
  } else if (eventType == 'encounter update') {
    apicall6 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Friend\'s Activity',
      body:
          '${user.firstOrNull?.fullName} added an update to an encounter. Remember to ask about it!',
    );

    if ((apicall6.succeeded ?? true)) {
      return;
    }

    return;
  } else {
    apicall3 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: 'Friend\'s Activity',
      body: '${user.firstOrNull?.fullName} just recorded a new encounter! 🙏',
    );

    if ((apicall3.succeeded ?? true)) {
      return;
    }

    return;
  }
}

Future calculateStreak(BuildContext context) async {
  List<XpEventsRow>? xpEvent;
  List<dynamic>? streak;

  xpEvent = await XpEventsTable().queryRows(
    queryFn: (q) => q.eqOrNull(
      'user_id',
      currentUserUid,
    ),
  );
  streak = await actions.calculateStreak(
    xpEvent.map((e) => e.createdAt).withoutNulls.toList().toList(),
    FFAppState().currentStreak,
  );
  FFAppState().currentStreak = getJsonField(
    streak.elementAtOrNull(1),
    r'''$.streak''',
  );
  await UsersTable().update(
    data: {
      'streak': FFAppState().currentStreak,
    },
    matchingRows: (rows) => rows.eqOrNull(
      'id',
      currentUserUid,
    ),
  );
  if (getJsonField(
    streak.lastOrNull,
    r'''$.is_streak''',
  )) {
    await showDialog(
      barrierColor: FlutterFlowTheme.of(context).primaryBackground,
      barrierDismissible: false,
      context: context,
      builder: (dialogContext) {
        return Dialog(
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          alignment: AlignmentDirectional(0.0, 0.0)
              .resolve(Directionality.of(context)),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: StreakWidget(
              streakAmount: getJsonField(
                streak?.elementAtOrNull(1),
                r'''$.streak''',
              ).toString(),
              streakDays: getJsonField(
                streak?.firstOrNull,
                r'''$.active_days''',
                true,
              ),
            ),
          ),
        );
      },
    );
  }
}
