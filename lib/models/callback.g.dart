// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Callback _$CallbackFromJson(Map<String, dynamic> json) => Callback()
  ..type = json['type'] as String?
  ..message = json['message'] as String?
  ..invoker =
      (json['invoker'] as List<dynamic>?)?.map((e) => e as String).toList()
  ..status = json['status'] as int?
  ..subMessage =
      (json['subMessage'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$CallbackToJson(Callback instance) => <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'invoker': instance.invoker,
      'status': instance.status,
      'subMessage': instance.subMessage,
    };
