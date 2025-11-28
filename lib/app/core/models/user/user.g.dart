// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  uid: json['uid'] as String,
  email: json['email'] as String,
  fullName: json['fullName'] as String,
  firstName: json['firstName'] as String,
  photoUrl: json['photoUrl'] as String?,
  isEmailVerified: json['isEmailVerified'] as bool,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'fullName': instance.fullName,
  'firstName': instance.firstName,
  'photoUrl': instance.photoUrl,
  'isEmailVerified': instance.isEmailVerified,
  'createdAt': instance.createdAt?.toIso8601String(),
};
