import 'dart:convert';

class UserDetail {
  UserDetail({
    this.id,
    this.email,
    this.displayName,
    this.profilePhoto,
    this.userName,
  });

  String id;
  String email;
  String displayName;
  String profilePhoto;
  String userName;

  factory UserDetail.fromJson(String str) =>
      UserDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserDetail.fromMap(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        email: json["email"],
        displayName: json["displayName"],
        profilePhoto: json["profilePhoto"],
        userName: json["userName"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "displayName": displayName,
        "profilePhoto": profilePhoto,
        "userName": userName,
      };
}
