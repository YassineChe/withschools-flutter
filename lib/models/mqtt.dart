import 'package:json_annotation/json_annotation.dart';

part 'mqtt.g.dart';

@JsonSerializable()
class Mqtt {
  //Empty constructor
  Mqtt();

  /* Attributes */
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'school_id')
  int? schoolId;

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'password')
  String? password;

  factory Mqtt.fromJson(Map<String, dynamic> json) => _$MqttFromJson(json);
  Map<String, dynamic> toJson() => _$MqttToJson(this);
}
