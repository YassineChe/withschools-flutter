// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Student _$StudentFromJson(Map<String, dynamic> json) => Student()
  ..id = json['id'] as int?
  ..tutorId = json['tutor_id'] as int?
  ..fullName = json['full_name'] as String?
  ..brand = json['last_name'] as String?
  ..firstName = json['first_name'] as String?
  ..avatar = json['avatar'] as String?
  ..isActive = json['is_active'] as bool?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
      'id': instance.id,
      'tutor_id': instance.tutorId,
      'full_name': instance.fullName,
      'last_name': instance.brand,
      'first_name': instance.firstName,
      'avatar': instance.avatar,
      'is_active': instance.isActive,
      'created_at': instance.createdAt,
    };
