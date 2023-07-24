import 'package:json_annotation/json_annotation.dart';

import 'student.dart';
part 'trace.g.dart';

@JsonSerializable()
class Trace {
  //Empty constructor
  Trace();

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'journey_id')
  int? journeyId;

  @JsonKey(name: 'student_id')
  int? studentId;

  @JsonKey(name: 'student')
  Student? student;

  factory Trace.fromJson(Map<String, dynamic> json) => _$TraceFromJson(json);
  Map<String, dynamic> toJson() => _$TraceToJson(this);
}
