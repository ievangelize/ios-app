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
        'Authorization': 'Bearer $token',
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
  "situation": "<$situation>"
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
          'https://api.ievangelize.app/rest/v1/resources?search_metadata_tsv=plfts(english).$keyword',
      callType: ApiCallType.GET,
      headers: {
        'apikey': '$supabaseKey',
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
