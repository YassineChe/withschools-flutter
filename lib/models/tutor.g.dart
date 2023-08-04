// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tutor _$TutorFromJson(Map<String, dynamic> json) => Tutor()
  ..id = json['id'] as int?
  ..schoolId = json['school_id'] as int?
  ..fullName = json['full_name'] as String?
  ..brand = json['last_name'] as String?
  ..firstName = json['first_name'] as String?
  ..email = json['email'] as String?
  ..coordinates = json['coordinates'] as String?
  ..lat = (json['lat'] as num?)?.toDouble()
  ..lng = (json['lng'] as num?)?.toDouble()
  ..avatar = json['avatar'] as String?
  ..radius = (json['radius'] as num?)?.toDouble()
  ..isActive = json['is_active'] as bool?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$TutorToJson(Tutor instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'full_name': instance.fullName,
      'last_name': instance.brand,
      'first_name': instance.firstName,
      'email': instance.email,
      'coordinates': instance.coordinates,
      'lat': instance.lat,
      'lng': instance.lng,
      'avatar': instance.avatar,
      'radius': instance.radius,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
