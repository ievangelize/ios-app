import 'dart:convert';

import 'package:flutter/material.dart';

import '/backend/schema/structs/index.dart';

import '/backend/supabase/supabase.dart';

import '../../flutter_flow/place.dart';
import '../../flutter_flow/uploaded_file.dart';

/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(FFPlace place) => jsonEncode({
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String uploadedFileToString(FFUploadedFile uploadedFile) =>
    uploadedFile.serialize();

String? serializeParam(
  dynamic param,
  ParamType paramType, {
  bool isList = false,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType, isList: false))
          .where((p) => p != null)
          .map((p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    String? data;
    switch (paramType) {
      case ParamType.int:
        data = param.toString();
      case ParamType.double:
        data = param.toString();
      case ParamType.String:
        data = param;
      case ParamType.bool:
        data = param ? 'true' : 'false';
      case ParamType.DateTime:
        data = (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.DateTimeRange:
        data = dateTimeRangeToString(param as DateTimeRange);
      case ParamType.LatLng:
        data = (param as LatLng).serialize();
      case ParamType.Color:
        data = (param as Color).toCssString();
      case ParamType.FFPlace:
        data = placeToString(param as FFPlace);
      case ParamType.FFUploadedFile:
        data = uploadedFileToString(param as FFUploadedFile);
      case ParamType.JSON:
        data = json.encode(param);

      case ParamType.DataStruct:
        data = param is BaseStruct ? param.serialize() : null;

      case ParamType.SupabaseRow:
        return json.encode((param as SupabaseDataRow).data);

      default:
        data = null;
    }
    return data;
  } catch (e) {
    print('Error serializing parameter: $e');
    return null;
  }
}

/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String? latLngStr) {
  final pieces = latLngStr?.split(',');
  if (pieces == null || pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

FFPlace placeFromString(String placeStr) {
  final serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return FFPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

FFUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    FFUploadedFile.deserialize(uploadedFileStr);

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,

  DataStruct,
  SupabaseRow,

  CustomClass,
  CustomEnum,
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList, {
  StructBuilder<T>? structBuilder,
}) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .where((p) => p is String)
          .map((p) => p as String)
          .map((p) => deserializeParam<T>(
                p,
                paramType,
                false,
                structBuilder: structBuilder,
              ))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.DateTime:
        final milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.DateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.LatLng:
        return latLngFromString(param);
      case ParamType.Color:
        return fromCssColor(param);
      case ParamType.FFPlace:
        return placeFromString(param);
      case ParamType.FFUploadedFile:
        return uploadedFileFromString(param);
      case ParamType.JSON:
        return json.decode(param);

      case ParamType.SupabaseRow:
        final data = json.decode(param) as Map<String, dynamic>;
        switch (T) {
          case QuotesRow:
            return QuotesRow(data);
          case TiersRow:
            return TiersRow(data);
          case MissionsCatalogRow:
            return MissionsCatalogRow(data);
          case EncounterFieldValuesRow:
            return EncounterFieldValuesRow(data);
          case FormsRow:
            return FormsRow(data);
          case ResourcesRow:
            return ResourcesRow(data);
          case NoAuthMissionRow:
            return NoAuthMissionRow(data);
          case ImpactRow:
            return ImpactRow(data);
          case UserGroupsRow:
            return UserGroupsRow(data);
          case CoursesRow:
            return CoursesRow(data);
          case UserMissionsRow:
            return UserMissionsRow(data);
          case EncounterFieldValueOptionsRow:
            return EncounterFieldValueOptionsRow(data);
          case CourseLessonsRow:
            return CourseLessonsRow(data);
          case UserCampaignsRow:
            return UserCampaignsRow(data);
          case ConversationsRow:
            return ConversationsRow(data);
          case ExperienceVideosRow:
            return ExperienceVideosRow(data);
          case SimulatorPersonasRow:
            return SimulatorPersonasRow(data);
          case FieldOptionsRow:
            return FieldOptionsRow(data);
          case StoriesRow:
            return StoriesRow(data);
          case XpEventsRow:
            return XpEventsRow(data);
          case ResourceProvidersRow:
            return ResourceProvidersRow(data);
          case GroupsRow:
            return GroupsRow(data);
          case QuizzesRow:
            return QuizzesRow(data);
          case ChallengeWeeksRow:
            return ChallengeWeeksRow(data);
          case LessonsRow:
            return LessonsRow(data);
          case ConversationMessagesRow:
            return ConversationMessagesRow(data);
          case ChurchesRow:
            return ChurchesRow(data);
          case LessonPagesRow:
            return LessonPagesRow(data);
          case MissionsRow:
            return MissionsRow(data);
          case FilterTagsRow:
            return FilterTagsRow(data);
          case UserAssignedMissionsRow:
            return UserAssignedMissionsRow(data);
          case UserCourseProgressRow:
            return UserCourseProgressRow(data);
          case UsersRow:
            return UsersRow(data);
          case SituationRow:
            return SituationRow(data);
          case CategoriesRow:
            return CategoriesRow(data);
          case UserLessonProgressRow:
            return UserLessonProgressRow(data);
          case ActivityReactionsRow:
            return ActivityReactionsRow(data);
          case CampaignsRow:
            return CampaignsRow(data);
          case QuizOptionsRow:
            return QuizOptionsRow(data);
          case FormFieldsRow:
            return FormFieldsRow(data);
          case ReachedRow:
            return ReachedRow(data);
          case SimulatorFeedbackRow:
            return SimulatorFeedbackRow(data);
          case FriendsRow:
            return FriendsRow(data);
          case LevelsRow:
            return LevelsRow(data);
          case ScheduledNotificationsRow:
            return ScheduledNotificationsRow(data);
          default:
            return null;
        }

      case ParamType.DataStruct:
        final data = json.decode(param) as Map<String, dynamic>? ?? {};
        return structBuilder != null ? structBuilder(data) : null;

      default:
        return null;
    }
  } catch (e) {
    print('Error deserializing parameter: $e');
    return null;
  }
}
