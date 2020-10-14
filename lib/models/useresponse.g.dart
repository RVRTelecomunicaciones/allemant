// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'useresponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Useresponse _$UseresponseFromJson(Map<String, dynamic> json) {
  return Useresponse(
    status: json['status'] as bool,
    message: json['message'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UseresponseToJson(Useresponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user?.toJson(),
    };
