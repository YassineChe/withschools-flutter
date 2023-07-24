import 'package:json_annotation/json_annotation.dart';

part 'bus.g.dart';

@JsonSerializable()
class Bus {
  //Empty constructor
  Bus();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'school_id')
  int? schoolId;

  @JsonKey(name: 'brand')
  String? brand;

  @JsonKey(name: 'registration_number')
  String? registrationNumber;

  @JsonKey(name: 'capacity')
  int? capacity;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory Bus.fromJson(Map<String, dynamic> json) => _$BusFromJson(json);
  Map<String, dynamic> toJson() => _$BusToJson(this);
}
