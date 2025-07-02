import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
  includeIfNull: false,
)
class User {
  String uid;
  String email;
  String fullName;
  String firstName;
  String? photoUrl;
  bool isEmailVerified;
  DateTime? createdAt;

  User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.firstName,
    this.photoUrl,
    required this.isEmailVerified,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserToJson(this);
}