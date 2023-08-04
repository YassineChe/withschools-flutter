import 'package:json_annotation/json_annotation.dart';

part 'tutor.g.dart';

@JsonSerializable()
class Tutor {
  //Empty constructor
  Tutor();

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

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'coordinates')
  String? coordinates;

  @JsonKey(name: 'lat')
  double? lat;

  @JsonKey(name: 'lng')
  double? lng;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'radius')
  double? radius;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory Tutor.fromJson(Map<String, dynamic> json) => _$TutorFromJson(json);
  Map<String, dynamic> toJson() => _$TutorToJson(this);
}
