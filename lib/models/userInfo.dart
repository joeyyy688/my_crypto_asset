// ignore_for_file: file_names

import 'dart:convert';

class UserInfoData {
  final String displayName;
  final String email;
  final String photoUrl;

  UserInfoData({
    required this.displayName,
    required this.email,
    required this.photoUrl,
  });

  factory UserInfoData.fromRawJson(String str) =>
      UserInfoData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
        displayName: json["displayName"],
        email: json["email"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}
