import 'dart:convert';

class AvatarDetails {
  AvatarDetails({
    this.avatarLink,
  });

  String avatarLink;

  factory AvatarDetails.fromJson(String str) =>
      AvatarDetails.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AvatarDetails.fromMap(Map<String, dynamic> json) => AvatarDetails(
        avatarLink: json["avatarLink"],
      );

  Map<String, dynamic> toMap() => {
        "avatarLink": avatarLink,
      };
}
