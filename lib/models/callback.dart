import 'package:json_annotation/json_annotation.dart';

part 'callback.g.dart';

@JsonSerializable()
class Callback {
  //Empty constructor
  Callback();

  /* Attributes */
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'invoker')
  List<String>? invoker;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'subMessage')
  List<String>? subMessage;

  factory Callback.fromJson(Map<String, dynamic> json) => _$CallbackFromJson(json);
  Map<String, dynamic> toJson() => _$CallbackToJson(this);
}
