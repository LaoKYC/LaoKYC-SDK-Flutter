import 'dart:convert';

OneIDResetOTP oneIDResetModelFromJson(String str) => OneIDResetOTP.fromJson(json.decode(str));

String oneIDResetOTPModelToJson(OneIDResetOTP data) => json.encode(data.toJson());

class OneIDResetOTP {
  OneIDResetOTP({
    this.code,
    this.message,
    this.isSuccess,
    this.detail,
  });

  String? code;
  String? message;
  bool? isSuccess;
  dynamic detail;

  factory OneIDResetOTP.fromJson(Map<String, dynamic> json) => OneIDResetOTP(
    code: json["code"] == null ? null : json["code"],
    message: json["message"] == null ? null : json["message"],
    isSuccess: json["isSuccess"] == null ? null : json["isSuccess"],
    detail: json["detail"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "message": message == null ? null : message,
    "isSuccess": isSuccess == null ? null : isSuccess,
    "detail": detail,
  };
}
