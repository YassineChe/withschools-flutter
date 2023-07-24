// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journey _$JourneyFromJson(Map<String, dynamic> json) => Journey()
  ..id = json['id'] as int?
  ..schoolId = json['school_id'] as int?
  ..busId = json['bus_id'] as int?
  ..driverId = json['driver_id'] as int?
  ..studentsCount = json['students_count'] as int?
  ..supervisorId = json['supervisor_id'] as int?
  ..name = json['name'] as String?
  ..bus = json['bus'] == null
      ? null
      : Bus.fromJson(json['bus'] as Map<String, dynamic>)
  ..driver = json['driver'] == null
      ? null
      : Driver.fromJson(json['driver'] as Map<String, dynamic>)
  ..traces = (json['traces'] as List<dynamic>?)
      ?.map((e) => Trace.fromJson(e as Map<String, dynamic>))
      .toList()
  ..students = (json['students'] as List<dynamic>?)
      ?.map((e) => Student.fromJson(e as Map<String, dynamic>))
      .toList()
  ..isActive = json['is_active'] as bool?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$JourneyToJson(Journey instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'bus_id': instance.busId,
      'driver_id': instance.driverId,
      'students_count': instance.studentsCount,
      'supervisor_id': instance.supervisorId,
      'name': instance.name,
      'bus': instance.bus,
      'driver': instance.driver,
      'traces': instance.traces,
      'students': instance.students,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
