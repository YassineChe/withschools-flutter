// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..id = json['id'] as int?
  ..fullName = json['full_name'] as String?
  ..firstName = json['first_name'] as String?
  ..lastName = json['last_name'] as String?
  ..phoneNumber = json['phone_number'] as String?
  ..email = json['email'] as String?
  ..guard = json['guard'] as String?
  ..token = json['token'] as String?
  ..avatar = json['avatar'] as String?
  ..location = json['location'] as String?
  ..locale = json['locale'] as String?
  ..createdAt = json['created_at'] as String?;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'email': instance.email,
      'guard': instance.guard,
      'token': instance.token,
      'avatar': instance.avatar,
      'location': instance.location,
      'locale': instance.locale,
      'created_at': instance.createdAt,
    };
