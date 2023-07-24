// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Driver _$DriverFromJson(Map<String, dynamic> json) => Driver()
  ..id = json['id'] as int?
  ..schoolId = json['school_id'] as int?
  ..fullName = json['full_name'] as String?
  ..brand = json['last_name'] as String?
  ..firstName = json['first_name'] as String?
  ..avatar = json['avatar'] as String?
  ..isActive = json['is_active'] as bool?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$DriverToJson(Driver instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'full_name': instance.fullName,
      'last_name': instance.brand,
      'first_name': instance.firstName,
      'avatar': instance.avatar,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
