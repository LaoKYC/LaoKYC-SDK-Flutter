class OTPResponse {
  final int code;
  final String message;

  OTPResponse({this.code, this.message});

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      code: json['code'],
      message: json['message'],
    );
  }
}
