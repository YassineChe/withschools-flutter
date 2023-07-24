import 'package:json_annotation/json_annotation.dart';

part 'driver.g.dart';

@JsonSerializable()
class Driver {
  //Empty constructor
  Driver();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'school_id')
  int? schoolId;

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'last_name')
  String? brand;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory Driver.fromJson(Map<String, dynamic> json) => _$DriverFromJson(json);
  Map<String, dynamic> toJson() => _$DriverToJson(this);
}
