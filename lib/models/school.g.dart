// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

School _$SchoolFromJson(Map<String, dynamic> json) => School()
  ..id = json['id'] as int?
  ..countryId = json['country_id'] as int?
  ..name = json['name'] as String?
  ..email = json['email'] as String?
  ..address = json['address'] as String?
  ..lat = (json['lat'] as num?)?.toDouble()
  ..lng = (json['lng'] as num?)?.toDouble()
  ..locale = json['locale'] as String?
  ..avatar = json['avatar'] as String?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$SchoolToJson(School instance) => <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'name': instance.name,
      'email': instance.email,
      'address': instance.address,
      'lat': instance.lat,
      'lng': instance.lng,
      'locale': instance.locale,
      'avatar': instance.avatar,
      'created_at': instance.createdAt,
    };
