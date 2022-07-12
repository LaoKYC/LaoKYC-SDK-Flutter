import 'dart:convert';

ConnectRefreshTokenModel connectRefreshTokenModelFromJson(String str) => ConnectRefreshTokenModel.fromJson(json.decode(str));

String connectRefreshTokenModelToJson(ConnectRefreshTokenModel data) => json.encode(data.toJson());

class ConnectRefreshTokenModel {
  ConnectRefreshTokenModel({
    this.code,
    this.message,
    this.isSuccess,
    this.detail,
    this.accessToken,
    this.expire,
    this.refreshToken,
  });

  String? code;
  String? message;
  bool? isSuccess;
  String? detail;
  String? accessToken;
  int? expire;
  String? refreshToken;

  factory ConnectRefreshTokenModel.fromJson(Map<String, dynamic> json) => ConnectRefreshTokenModel(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    detail: json["detail"] == null ? null : json["detail"],
    accessToken: json["accessToken"] == null ? null : json["accessToken"],
    expire: json["expire"] == null ? null : json["expire"],
    refreshToken: json["refreshToken"] == null ? null : json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "isSuccess": isSuccess == null ? null : isSuccess,
    "detail": detail == null ? null : detail,
    "accessToken": accessToken == null ? null : accessToken,
    "expire": expire == null ? null : expire,
    "refreshToken": refreshToken == null ? null : refreshToken,
  };
}
