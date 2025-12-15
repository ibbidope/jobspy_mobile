// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
  company: json['company'] as String?,
  companyUrl: json['company_url'] as String?,
  companyLogo: json['company_logo'] as String?,
  companyNumEmployees: json['company_num_employees'] as String?,
  companyUrlDirect: json['company_url_direct'] as String?,
  title: json['title'] as String?,
  location: json['location'] as String?,
  jobType: json['job_type'] as String?,
  jobUrl: json['job_url'] as String?,
  salarySource: json['salary_source'] as String?,
  site: json['site'] as String?,
  description: json['description'] as String?,
  datePosted: json['date_posted'] as String?,
  jobUrlDirect: json['job_url_direct'] as String?,
);

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
  'company': instance.company,
  'company_url': instance.companyUrl,
  'company_logo': instance.companyLogo,
  'company_num_employees': instance.companyNumEmployees,
  'company_url_direct': instance.companyUrlDirect,
  'title': instance.title,
  'location': instance.location,
  'job_type': instance.jobType,
  'job_url': instance.jobUrl,
  'salary_source': instance.salarySource,
  'site': instance.site,
  'description': instance.description,
  'date_posted': instance.datePosted,
  'job_url_direct': instance.jobUrlDirect,
};
