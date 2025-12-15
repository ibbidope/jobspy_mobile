import 'package:json_annotation/json_annotation.dart';

part 'health_model.g.dart';

@JsonSerializable()
class HealthModel {
  @JsonKey(includeToJson: false)
  final String healthStatus;

  HealthModel({required this.healthStatus});

  factory HealthModel.fromJson(Map<String, dynamic> json) =>
      _$HealthModelFromJson(json);

  Map<String, dynamic> toJson() => _$HealthModelToJson(this);
}
