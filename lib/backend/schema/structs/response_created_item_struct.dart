// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponseCreatedItemStruct extends BaseStruct {
  ResponseCreatedItemStruct({
    String? id,
    String? status,
    String? previousResponseId,
  })  : _id = id,
        _status = status,
        _previousResponseId = previousResponseId;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  // "previous_response_id" field.
  String? _previousResponseId;
  String get previousResponseId => _previousResponseId ?? '';
  set previousResponseId(String? val) => _previousResponseId = val;

  bool hasPreviousResponseId() => _previousResponseId != null;

  static ResponseCreatedItemStruct fromMap(Map<String, dynamic> data) =>
      ResponseCreatedItemStruct(
        id: data['id'] as String?,
        status: data['status'] as String?,
        previousResponseId: data['previous_response_id'] as String?,
      );

  static ResponseCreatedItemStruct? maybeFromMap(dynamic data) => data is Map
      ? ResponseCreatedItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'status': _status,
        'previous_response_id': _previousResponseId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
        'previous_response_id': serializeParam(
          _previousResponseId,
          ParamType.String,
        ),
      }.withoutNulls;

  static ResponseCreatedItemStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ResponseCreatedItemStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
        previousResponseId: deserializeParam(
          data['previous_response_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ResponseCreatedItemStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ResponseCreatedItemStruct &&
        id == other.id &&
        status == other.status &&
        previousResponseId == other.previousResponseId;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, status, previousResponseId]);
}

ResponseCreatedItemStruct createResponseCreatedItemStruct({
  String? id,
  String? status,
  String? previousResponseId,
}) =>
    ResponseCreatedItemStruct(
      id: id,
      status: status,
      previousResponseId: previousResponseId,
    );
