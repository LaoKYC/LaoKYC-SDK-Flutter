// To parse this JSON data, do
//
//     final modelProfile = modelProfileFromJson(jsonString);

import 'dart:convert';

ModelProfile modelProfileFromJson(String str) =>
    ModelProfile.fromJson(json.decode(str));

String modelProfileToJson(ModelProfile data) => json.encode(data.toJson());

class ModelProfile {
  ModelProfile({
    required this.code,
    required this.message,
    required this.isSuccess,
    required this.profile,
  });

  String code;
  String message;
  bool isSuccess;
  Profile profile;

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
        code: json["code"],
        message: json["message"],
        isSuccess: json["isSuccess"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "isSuccess": isSuccess,
        "profile": profile.toJson(),
      };
}

class Profile {
  Profile({
    required this.id,
    required this.name,
    required this.surname,
    required this.gender,
    required this.birthday,
    required this.thumbnail,
  });

  String id;
  String name;
  String surname;
  int gender;
  String birthday;
  Thumbnail thumbnail;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        gender: json["gender"],
        birthday: json["birthday"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "gender": gender,
        "birthday": birthday,
        "thumbnail": thumbnail.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    required this.filename,
    required this.bucket,
  });

  String filename;
  String bucket;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        filename: json["filename"],
        bucket: json["bucket"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "bucket": bucket,
      };
}
