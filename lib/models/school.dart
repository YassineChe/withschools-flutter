import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  //Empty constructor
  School();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'country_id')
  int? countryId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'address')
  String? address;

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'lng')
  double? lng;

  @JsonKey(name: 'locale')
  String? locale;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
