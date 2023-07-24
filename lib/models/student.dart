import 'package:json_annotation/json_annotation.dart';

part 'student.g.dart';

@JsonSerializable()
class Student {
  //Empty constructor
  Student();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'tutor_id')
  int? tutorId;

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

  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);
  Map<String, dynamic> toJson() => _$StudentToJson(this);
}
