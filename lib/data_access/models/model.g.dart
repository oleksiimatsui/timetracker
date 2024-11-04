// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityModelImpl _$$ActivityModelImplFromJson(Map<String, dynamic> json) =>
    _$ActivityModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      color: json['color'] as String?,
      plannedSeconds: (json['plannedSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$$ActivityModelImplToJson(_$ActivityModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'plannedSeconds': instance.plannedSeconds,
    };

_$ActiveTDModelImpl _$$ActiveTDModelImplFromJson(Map<String, dynamic> json) =>
    _$ActiveTDModelImpl(
      id: (json['id'] as num).toInt(),
      isRunning: json['isRunning'] as bool,
      lastChangeTime: DateTime.parse(json['lastChangeTime'] as String),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
    );

Map<String, dynamic> _$$ActiveTDModelImplToJson(_$ActiveTDModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'isRunning': instance.isRunning,
      'lastChangeTime': instance.lastChangeTime.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
    };

_$PastTDModelImpl _$$PastTDModelImplFromJson(Map<String, dynamic> json) =>
    _$PastTDModelImpl(
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      activityId: (json['activityId'] as num).toInt(),
    );

Map<String, dynamic> _$$PastTDModelImplToJson(_$PastTDModelImpl instance) =>
    <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'activityId': instance.activityId,
    };
