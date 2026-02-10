// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MessageStruct extends BaseStruct {
  MessageStruct({
    String? id,
    String? role,
    List<String>? messages,
    DateTime? createdAt,
    bool? isHistory,
  })  : _id = id,
        _role = role,
        _messages = messages,
        _createdAt = createdAt,
        _isHistory = isHistory;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "role" field.
  String? _role;
  String get role => _role ?? '';
  set role(String? val) => _role = val;

  bool hasRole() => _role != null;

  // "messages" field.
  List<String>? _messages;
  List<String> get messages => _messages ?? const [];
  set messages(List<String>? val) => _messages = val;

  void updateMessages(Function(List<String>) updateFn) {
    updateFn(_messages ??= []);
  }

  bool hasMessages() => _messages != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  set createdAt(DateTime? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  // "isHistory" field.
  bool? _isHistory;
  bool get isHistory => _isHistory ?? false;
  set isHistory(bool? val) => _isHistory = val;

  bool hasIsHistory() => _isHistory != null;

  static MessageStruct fromMap(Map<String, dynamic> data) => MessageStruct(
        id: data['id'] as String?,
        role: data['role'] as String?,
        messages: getDataList(data['messages']),
        createdAt: data['created_at'] as DateTime?,
        isHistory: data['isHistory'] as bool?,
      );

  static MessageStruct? maybeFromMap(dynamic data) =>
      data is Map ? MessageStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'role': _role,
        'messages': _messages,
        'created_at': _createdAt,
        'isHistory': _isHistory,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'role': serializeParam(
          _role,
          ParamType.String,
        ),
        'messages': serializeParam(
          _messages,
          ParamType.String,
          isList: true,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.DateTime,
        ),
        'isHistory': serializeParam(
          _isHistory,
          ParamType.bool,
        ),
      }.withoutNulls;

  static MessageStruct fromSerializableMap(Map<String, dynamic> data) =>
      MessageStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        role: deserializeParam(
          data['role'],
          ParamType.String,
          false,
        ),
        messages: deserializeParam<String>(
          data['messages'],
          ParamType.String,
          true,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.DateTime,
          false,
        ),
        isHistory: deserializeParam(
          data['isHistory'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'MessageStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is MessageStruct &&
        id == other.id &&
        role == other.role &&
        listEquality.equals(messages, other.messages) &&
        createdAt == other.createdAt &&
        isHistory == other.isHistory;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([id, role, messages, createdAt, isHistory]);
}

MessageStruct createMessageStruct({
  String? id,
  String? role,
  DateTime? createdAt,
  bool? isHistory,
}) =>
    MessageStruct(
      id: id,
      role: role,
      createdAt: createdAt,
      isHistory: isHistory,
    );
