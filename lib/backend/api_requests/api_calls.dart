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

class OpenAIAPICall {
  static Future<ApiCallResponse> call({
    String? situation = '',
  }) async {
    final ffApiRequestBody = '''
{
  "situation": "<${situation}>"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'OpenAI API',
      apiUrl: 'https://api.ievangelize.app/functions/v1/openai-json',
      callType: ApiCallType.POST,
      headers: {
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

  static bool? success(dynamic response) => castToType<bool>(getJsonField(
        response,
        r'''$.success''',
      ));
  static String? pray(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.Pray''',
      ));
}

class SearchResourcesCall {
  static Future<ApiCallResponse> call({
    String? supabaseKey =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ2b2Z6a3BieGp0am9maHBkY3V1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTI4Nzk4OTUsImV4cCI6MjAyODQ1NTg5NX0.p7VWByVny8KrEJF_SXuTPVTtctCyMou7Bwxr2X4CszU',
    String? keyword = '',
  }) async {
    return ApiManager.instance.makeApiCall(
      callName: 'Search Resources',
      apiUrl:
          'https://api.ievangelize.app/rest/v1/resources?search_metadata_tsv=plfts(english).${keyword}',
      callType: ApiCallType.GET,
      headers: {
        'apikey': '${supabaseKey}',
      },
      params: {},
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
  "user_id": "${userId}"
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

class EvangelismpediaFirstCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userText = '',
  }) async {
    final ffApiRequestBody = '''
{
  "prompt": {
    "id": "pmpt_690e81b0b1e481949a50453573ad77340d03b364c0bfcc60"
  },
  "input": [
    {
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "${escapeStringForJson(userText)}"
        }
      ]
    }
  ],
  "text": {
    "format": {
      "type": "text"
    }
  },
  "store": true,
  "stream": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Evangelismpedia First',
      apiUrl: 'https://api.openai.com/v1/responses',
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
      isStreamingApi: true,
      alwaysAllowBody: false,
    );
  }

  static String? reponseId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.id''',
      ));
}

class ConversationStartersCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userText = '',
  }) async {
    final ffApiRequestBody = '''
{
  "prompt": {
    "id": "pmpt_692b7c07ff448194bb43c9e3128d66a20b4e4a3edbb342b1"
  },
  "input": [
    {
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "${escapeStringForJson(userText)} json"
        }
      ]
    }
  ],
  "text": {
    "format": {
      "type": "json_object"
    }
  },
  "store": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Conversation Starters',
      apiUrl: 'https://api.openai.com/v1/responses',
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

  static dynamic content(dynamic response) => getJsonField(
        response,
        r'''$.output[:].content[:].text''',
      );
}

class EvangelismpediaNextMessageCall {
  static Future<ApiCallResponse> call({
    String? token = '',
    String? userText = '',
    String? previousResponseId = '',
  }) async {
    final ffApiRequestBody = '''
{
  "prompt": {
    "id": "pmpt_690e81b0b1e481949a50453573ad77340d03b364c0bfcc60"
  },
  "input": [
    {
      "role": "user",
      "content": [
        {
          "type": "input_text",
          "text": "${escapeStringForJson(userText)}"
        }
      ]
    }
  ],
  "text": {
    "format": {
      "type": "text"
    }
  },
  "previous_response_id": "${escapeStringForJson(previousResponseId)}",
  "store": true,
  "stream": true
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Evangelismpedia Next Message',
      apiUrl: 'https://api.openai.com/v1/responses',
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
      isStreamingApi: true,
      alwaysAllowBody: false,
    );
  }

  static String? reponseId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.response.id''',
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
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
