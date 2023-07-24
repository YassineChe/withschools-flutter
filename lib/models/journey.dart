import 'package:json_annotation/json_annotation.dart';

import 'bus.dart';
import 'driver.dart';
import 'trace.dart';
import 'student.dart';

part 'journey.g.dart';

@JsonSerializable()
class Journey {
  //Empty constructor
  Journey();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'school_id')
  int? schoolId;

  @JsonKey(name: 'bus_id')
  int? busId;

  @JsonKey(name: 'driver_id')
  int? driverId;

  @JsonKey(name: 'students_count')
  int? studentsCount;

  @JsonKey(name: 'supervisor_id')
  int? supervisorId;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'bus')
  Bus? bus;

  @JsonKey(name: 'driver')
  Driver? driver;

  @JsonKey(name: 'traces')
  List<Trace>? traces;

  @JsonKey(name: 'students')
  List<Student>? students;

  @JsonKey(name: 'is_active')
  bool? isActive;

  @JsonKey(name: 'created_at')
  String? createdAt;

  factory Journey.fromJson(Map<String, dynamic> json) => _$JourneyFromJson(json);
  Map<String, dynamic> toJson() => _$JourneyToJson(this);
}
