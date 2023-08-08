// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mqtt _$MqttFromJson(Map<String, dynamic> json) => Mqtt()
  ..id = json['id'] as int?
  ..schoolId = json['school_id'] as int?
  ..username = json['username'] as String?
  ..password = json['password'] as String?;

Map<String, dynamic> _$MqttToJson(Mqtt instance) => <String, dynamic>{
      'id': instance.id,
      'school_id': instance.schoolId,
      'username': instance.username,
      'password': instance.password,
    };
