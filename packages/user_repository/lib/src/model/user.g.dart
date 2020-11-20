// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['user_id'] as String,
    json['token'] as String,
    json['type'] as String,
    json['profile_id'] as int,
    json['phone'] as String,
    json['full_name'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('type', instance.type);
  writeNotNull('token', instance.token);
  writeNotNull('profile_id', instance.profileId);
  writeNotNull('phone', instance.phone);
  writeNotNull('full_name', instance.fullName);
  return val;
}
