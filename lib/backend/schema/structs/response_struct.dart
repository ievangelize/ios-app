// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponseStruct extends BaseStruct {
  ResponseStruct({
    String? type,
    int? sequenceNumber,
    String? itemId,
    int? outputIndex,
    int? contentIndex,
    String? delta,
    List<String>? logprobs,
    String? obfuscation,
    ResponseCreatedItemStruct? response,
  })  : _type = type,
        _sequenceNumber = sequenceNumber,
        _itemId = itemId,
        _outputIndex = outputIndex,
        _contentIndex = contentIndex,
        _delta = delta,
        _logprobs = logprobs,
        _obfuscation = obfuscation,
        _response = response;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "sequence_number" field.
  int? _sequenceNumber;
  int get sequenceNumber => _sequenceNumber ?? 0;
  set sequenceNumber(int? val) => _sequenceNumber = val;

  void incrementSequenceNumber(int amount) =>
      sequenceNumber = sequenceNumber + amount;

  bool hasSequenceNumber() => _sequenceNumber != null;

  // "item_id" field.
  String? _itemId;
  String get itemId => _itemId ?? '';
  set itemId(String? val) => _itemId = val;

  bool hasItemId() => _itemId != null;

  // "output_index" field.
  int? _outputIndex;
  int get outputIndex => _outputIndex ?? 0;
  set outputIndex(int? val) => _outputIndex = val;

  void incrementOutputIndex(int amount) => outputIndex = outputIndex + amount;

  bool hasOutputIndex() => _outputIndex != null;

  // "content_index" field.
  int? _contentIndex;
  int get contentIndex => _contentIndex ?? 0;
  set contentIndex(int? val) => _contentIndex = val;

  void incrementContentIndex(int amount) =>
      contentIndex = contentIndex + amount;

  bool hasContentIndex() => _contentIndex != null;

  // "delta" field.
  String? _delta;
  String get delta => _delta ?? '';
  set delta(String? val) => _delta = val;

  bool hasDelta() => _delta != null;

  // "logprobs" field.
  List<String>? _logprobs;
  List<String> get logprobs => _logprobs ?? const [];
  set logprobs(List<String>? val) => _logprobs = val;

  void updateLogprobs(Function(List<String>) updateFn) {
    updateFn(_logprobs ??= []);
  }

  bool hasLogprobs() => _logprobs != null;

  // "obfuscation" field.
  String? _obfuscation;
  String get obfuscation => _obfuscation ?? '';
  set obfuscation(String? val) => _obfuscation = val;

  bool hasObfuscation() => _obfuscation != null;

  // "response" field.
  ResponseCreatedItemStruct? _response;
  ResponseCreatedItemStruct get response =>
      _response ?? ResponseCreatedItemStruct();
  set response(ResponseCreatedItemStruct? val) => _response = val;

  void updateResponse(Function(ResponseCreatedItemStruct) updateFn) {
    updateFn(_response ??= ResponseCreatedItemStruct());
  }

  bool hasResponse() => _response != null;

  static ResponseStruct fromMap(Map<String, dynamic> data) => ResponseStruct(
        type: data['type'] as String?,
        sequenceNumber: castToType<int>(data['sequence_number']),
        itemId: data['item_id'] as String?,
        outputIndex: castToType<int>(data['output_index']),
        contentIndex: castToType<int>(data['content_index']),
        delta: data['delta'] as String?,
        logprobs: getDataList(data['logprobs']),
        obfuscation: data['obfuscation'] as String?,
        response: data['response'] is ResponseCreatedItemStruct
            ? data['response']
            : ResponseCreatedItemStruct.maybeFromMap(data['response']),
      );

  static ResponseStruct? maybeFromMap(dynamic data) =>
      data is Map ? ResponseStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'sequence_number': _sequenceNumber,
        'item_id': _itemId,
        'output_index': _outputIndex,
        'content_index': _contentIndex,
        'delta': _delta,
        'logprobs': _logprobs,
        'obfuscation': _obfuscation,
        'response': _response?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'sequence_number': serializeParam(
          _sequenceNumber,
          ParamType.int,
        ),
        'item_id': serializeParam(
          _itemId,
          ParamType.String,
        ),
        'output_index': serializeParam(
          _outputIndex,
          ParamType.int,
        ),
        'content_index': serializeParam(
          _contentIndex,
          ParamType.int,
        ),
        'delta': serializeParam(
          _delta,
          ParamType.String,
        ),
        'logprobs': serializeParam(
          _logprobs,
          ParamType.String,
          isList: true,
        ),
        'obfuscation': serializeParam(
          _obfuscation,
          ParamType.String,
        ),
        'response': serializeParam(
          _response,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResponseStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        sequenceNumber: deserializeParam(
          data['sequence_number'],
          ParamType.int,
          false,
        ),
        itemId: deserializeParam(
          data['item_id'],
          ParamType.String,
          false,
        ),
        outputIndex: deserializeParam(
          data['output_index'],
          ParamType.int,
          false,
        ),
        contentIndex: deserializeParam(
          data['content_index'],
          ParamType.int,
          false,
        ),
        delta: deserializeParam(
          data['delta'],
          ParamType.String,
          false,
        ),
        logprobs: deserializeParam<String>(
          data['logprobs'],
          ParamType.String,
          true,
        ),
        obfuscation: deserializeParam(
          data['obfuscation'],
          ParamType.String,
          false,
        ),
        response: deserializeStructParam(
          data['response'],
          ParamType.DataStruct,
          false,
          structBuilder: ResponseCreatedItemStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ResponseStruct &&
        type == other.type &&
        sequenceNumber == other.sequenceNumber &&
        itemId == other.itemId &&
        outputIndex == other.outputIndex &&
        contentIndex == other.contentIndex &&
        delta == other.delta &&
        listEquality.equals(logprobs, other.logprobs) &&
        obfuscation == other.obfuscation &&
        response == other.response;
  }

  @override
  int get hashCode => const ListEquality().hash([
        type,
        sequenceNumber,
        itemId,
        outputIndex,
        contentIndex,
        delta,
        logprobs,
        obfuscation,
        response
      ]);
}

ResponseStruct createResponseStruct({
  String? type,
  int? sequenceNumber,
  String? itemId,
  int? outputIndex,
  int? contentIndex,
  String? delta,
  String? obfuscation,
  ResponseCreatedItemStruct? response,
}) =>
    ResponseStruct(
      type: type,
      sequenceNumber: sequenceNumber,
      itemId: itemId,
      outputIndex: outputIndex,
      contentIndex: contentIndex,
      delta: delta,
      obfuscation: obfuscation,
      response: response ?? ResponseCreatedItemStruct(),
    );
