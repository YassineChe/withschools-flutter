// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trace.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trace _$TraceFromJson(Map<String, dynamic> json) => Trace()
  ..id = json['id'] as int?
  ..journeyId = json['journey_id'] as int?
  ..studentId = json['student_id'] as int?
  ..student = json['student'] == null
      ? null
      : Student.fromJson(json['student'] as Map<String, dynamic>);

Map<String, dynamic> _$TraceToJson(Trace instance) => <String, dynamic>{
      'id': instance.id,
      'journey_id': instance.journeyId,
      'student_id': instance.studentId,
      'student': instance.student,
    };
