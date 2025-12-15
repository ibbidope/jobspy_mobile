// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobModel _$JobModelFromJson(Map<String, dynamic> json) => JobModel(
  company: json['company'] as String?,
  companyUrl: json['companyUrl'] as String?,
  companyLogo: json['companyLogo'] as String?,
  companyNumEmployees: json['companyNumEmployees'] as String?,
  companyUrlDirect: json['companyUrlDirect'] as String?,
  title: json['title'] as String?,
  location: json['location'] as String?,
  jobType: json['jobType'] as String?,
  jobUrl: json['jobUrl'] as String?,
  salarySource: json['salarySource'] as String?,
  site: json['site'] as String?,
  description: json['description'] as String?,
  datePosted: json['datePosted'] as String?,
  jobUrlDirect: json['jobUrlDirect'] as String?,
);

Map<String, dynamic> _$JobModelToJson(JobModel instance) => <String, dynamic>{
  'company': instance.company,
  'companyUrl': instance.companyUrl,
  'companyLogo': instance.companyLogo,
  'companyNumEmployees': instance.companyNumEmployees,
  'companyUrlDirect': instance.companyUrlDirect,
  'title': instance.title,
  'location': instance.location,
  'jobType': instance.jobType,
  'jobUrl': instance.jobUrl,
  'salarySource': instance.salarySource,
  'site': instance.site,
  'description': instance.description,
  'datePosted': instance.datePosted,
  'jobUrlDirect': instance.jobUrlDirect,
};
