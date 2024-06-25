// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

BadRequestModel badRequestModelFromJson(String str) => BadRequestModel.fromJson(json.decode(str));

String badRequestModelToJson(BadRequestModel data) => json.encode(data.toJson());

class BadRequestModel {
  BadRequestModel({
    required this.code,
    required this.message,
    required this.isSuccess,
    required this.detail,
  });

  String code;
  String message;
  bool isSuccess;
  String? detail;

  factory BadRequestModel.fromJson(Map<String, dynamic> json) => BadRequestModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    detail: json["detail"] == null ? null : json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "isSuccess": isSuccess == null ? null : isSuccess,
    "detail": detail == null ? null : detail,
  };
}
