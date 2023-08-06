import 'package:json_annotation/json_annotation.dart';

import 'school.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  //Empty constructor
  User();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'first_name')
  String? firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'phone_number')
  String? phoneNumber;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'guard')
  String? guard;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'avatar')
  String? avatar;

  @JsonKey(name: 'school')
  School? school;

  @JsonKey(name: 'locale')
  String? locale;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
