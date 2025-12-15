import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  final String? company;
  final String? companyUrl;
  final String? companyLogo;
  final String? companyNumEmployees;
  final String? companyUrlDirect;
  final String? title;
  final String? location;
  final String? jobType;
  final String? jobUrl;
  final String? salarySource;
  final String? site;
  final String? description;
  final String? datePosted;
  final String? jobUrlDirect;

  JobModel({
    this.company,
    this.companyUrl,
    this.companyLogo,
    this.companyNumEmployees,
    this.companyUrlDirect,
    this.title,
    this.location,
    this.jobType,
    this.jobUrl,
    this.salarySource,
    this.site,
    this.description,
    this.datePosted,
    this.jobUrlDirect,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobModelToJson(this);
}
