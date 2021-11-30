import 'dart:convert';

ModelProfileFail modelProfileFailFromJson(String str) =>
    ModelProfileFail.fromJson(json.decode(str));

String modelProfileFailToJson(ModelProfileFail data) =>
    json.encode(data.toJson());

class ModelProfileFail {
  ModelProfileFail({
    this.code,
    this.message,
    this.isSuccess,
  });

  String code;
  String message;
  bool isSuccess;

  factory ModelProfileFail.fromJson(Map<String, dynamic> json) =>
      ModelProfileFail(
        code: json["code"],
        message: json["message"],
        isSuccess: json["isSuccess"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "isSuccess": isSuccess,
      };
}
