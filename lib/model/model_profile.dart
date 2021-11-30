import 'dart:convert';

ModelProfile modelProfileFromJson(String str) =>
    ModelProfile.fromJson(json.decode(str));

String modelProfileToJson(ModelProfile data) => json.encode(data.toJson());

class ModelProfile {
  ModelProfile({
    this.profile,
    this.code,
    this.message,
    this.isSuccess,
  });

  Profile profile;
  String code;
  String message;
  bool isSuccess;

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
        profile: Profile.fromJson(json["profile"]),
        code: json["code"],
        message: json["message"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile.toJson(),
        "code": code,
        "message": message,
        "isSuccess": isSuccess,
      };
}

class Profile {
  Profile({
    this.id,
    this.name,
    this.surname,
    this.gender,
    this.birthday,
    this.thumbnail,
    this.address,
    this.district,
    this.province,
  });

  String id;
  String name;
  String surname;
  int gender;
  String birthday;
  Thumbnail thumbnail;
  String address;
  String district;
  String province;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        gender: json["gender"],
        birthday: json["birthday"],
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        address: json["address"],
        district: json["district"],
        province: json["province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "gender": gender,
        "birthday": birthday,
        "thumbnail": thumbnail.toJson(),
        "address": address,
        "district": district,
        "province": province,
      };
}

class Thumbnail {
  Thumbnail({
    this.filename,
    this.bucket,
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
