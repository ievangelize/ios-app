import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class DeleteUserCall {
  static Future<ApiCallResponse> call({
    String? token = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Delete User',
      apiUrl: 'https://api.ievangelize.app/functions/v1/delete-user',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class AllocateCurrentCourseCall {
  static Future<ApiCallResponse> call({
    String? userId = '',
    String? token = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_id": ${userId == null ? 'null' : '"${userId}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Allocate Current Course',
      apiUrl:
          'https://api.ievangelize.app/functions/v1/allocate_current_course',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ConversationStartersCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userText = '',
  }) async {
    final ffApiRequestBody = '''
{
  "user_text": ${userText == null ? 'null' : '"${escapeStringForJson(userText)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Conversation Starters',
      apiUrl:
          'https://api.ievangelize.app/functions/v1/conversation-starters-openai',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
        'Content-Type': 'application/json',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static dynamic response(dynamic response) => getJsonField(
        response,
        r'''$.data''',
      );
  static bool? responsSuccess(dynamic response) =>
      castToType<bool>(getJsonField(
        response,
        r'''$.data.success''',
      ));
}

class SendPushNotificationCall {
  static Future<ApiCallResponse> call({
    String? supabaseToken = '',
    List<String>? userIdsList,
    String? title = '',
    String? body = '',
  }) async {
    final userIds = _serializeList(userIdsList);

    final ffApiRequestBody = '''
{
  "user_ids": ${userIds},
  "title": ${title == null ? 'null' : '"${escapeStringForJson(title)}"'},
  "body": ${body == null ? 'null' : '"${escapeStringForJson(body)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Push Notification',
      apiUrl: 'https://api.ievangelize.app/functions/v1/send-push',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${supabaseToken}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class SimulatorAnalyzerCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? conversation = '',
  }) async {
    final ffApiRequestBody = '''
{
  "conversation": ${conversation == null ? 'null' : '"${escapeStringForJson(conversation)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Simulator Analyzer',
      apiUrl:
          'https://api.ievangelize.app/functions/v1/simulator-analyzer-openai',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? feedbackTitle(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.feedback_title''',
      ));
  static String? feedbackResponse(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.response''',
      ));
}

class PersonaAIFirstCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userWords = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userWords": ${userWords == null ? 'null' : '"${escapeStringForJson(userWords)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Persona AI First',
      apiUrl: 'https://api.ievangelize.app/functions/v1/persona-ai-first',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response''',
      ));
  static String? responseID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.openai_response_id''',
      ));
}

class PrayerAICall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? targetDescription = '',
  }) async {
    final ffApiRequestBody = '''
{
  "targetDescription": ${targetDescription == null ? 'null' : '"${escapeStringForJson(targetDescription)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Prayer AI',
      apiUrl: 'https://api.ievangelize.app/functions/v1/prayer-ai-openai',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response''',
      ));
}

class PersonaAINextCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userWords = '',
    String? previousResponseId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "userWords": ${userWords == null ? 'null' : '"${escapeStringForJson(userWords)}"'},
  "previousResponseId": ${previousResponseId == null ? 'null' : '"${escapeStringForJson(previousResponseId)}"'}
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Persona AI Next',
      apiUrl: 'https://api.ievangelize.app/functions/v1/persona-ai-next',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token}',
        'apikey': '${token}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  static String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response''',
      ));
  static String? responseID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.openai_response_id''',
      ));
  static String? previousResponseID(dynamic response) =>
      castToType<String>(getJsonField(
        response,
        r'''$.previous_response_id''',
      ));
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  final encoded = jsonEncode(input);
  return encoded.substring(1, encoded.length - 1);
}
