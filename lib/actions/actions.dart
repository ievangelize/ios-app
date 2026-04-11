import '/auth/supabase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

Future sendFriendNotification(
  BuildContext context, {
  required String? eventType,
}) async {
  List<FriendsRow>? friends;
  List<UsersRow>? user;
  ApiCallResponse? apicall1;
  ApiCallResponse? apicall2;
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
      title: user.firstOrNull?.fullName,
      body: 'Just completed a course 🙌',
    );

    if ((apicall1.succeeded ?? true)) {
      return;
    }

    return;
  } else if (eventType == 'mission complete') {
    apicall2 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: user.firstOrNull?.fullName,
      body: 'Just completed a mission 🎯',
    );

    if ((apicall2.succeeded ?? true)) {
      return;
    }

    return;
  } else {
    apicall3 = await SendPushNotificationCall.call(
      supabaseToken: FFAppState().SupabaseKey,
      userIdsList: friends.map((e) => e.friendId).withoutNulls.toList(),
      title: user.firstOrNull?.fullName,
      body: 'Just recorded a new encounter 🙏',
    );

    if ((apicall3.succeeded ?? true)) {
      return;
    }

    return;
  }
}
