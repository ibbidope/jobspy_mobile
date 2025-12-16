import 'package:json_annotation/json_annotation.dart';

part 'job_model.g.dart';

@JsonSerializable()
class JobModel {
  final String? company;
  @JsonKey(name: 'company_url')
  final String? companyUrl;
  @JsonKey(name: 'company_logo')
  final String? companyLogo;
  @JsonKey(name: 'company_num_employees')
  final String? companyNumEmployees;
  @JsonKey(name: 'company_url_direct')
  final String? companyUrlDirect;
  final String? title;
  final String? location;
  @JsonKey(name: 'job_type')
  final String? jobType;
  @JsonKey(name: 'job_url')
  final String? jobUrl;
  @JsonKey(name: 'salary_source')
  final String? salarySource;
  final String? site;
  final String? description;
  @JsonKey(name: 'date_posted')
  final String? datePosted;
  @JsonKey(name: 'job_url_direct')
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
