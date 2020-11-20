import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable(nullable: true, includeIfNull: false)
class User extends Equatable{
    @JsonKey(name: "profile_id")
    final String userId;
    final String type;
    final String token;
    @JsonKey(name: "profile_id")
    final int profileId;
    @JsonKey(name:"user_id")
    final String phone;
    @JsonKey(name: "fullname")
    final String fullName;
    const User(this.userId, this.token, this.type, this.profileId, this.phone, this.fullName);
    factory User.fromJson(Map<String,dynamic> data) => _$UserFromJson(data);
    Map<String,dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object> get props => [];

  static const empty =   const User("","", "", -1, "","");
}