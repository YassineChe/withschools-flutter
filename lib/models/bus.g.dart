// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bus _$BusFromJson(Map<String, dynamic> json) => Bus()
  ..id = json['id'] as int?
  ..schoolId = json['school_id'] as int?
  ..brand = json['brand'] as String?
  ..registrationNumber = json['registration_number'] as String?
  ..capacity = json['capacity'] as int?
  ..isActive = json['is_active'] as bool?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$BusToJson(Bus instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'brand': instance.brand,
      'registration_number': instance.registrationNumber,
      'capacity': instance.capacity,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
