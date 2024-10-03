import 'dart:convert';

ApiBaseResponse baseResponseFromJson(String str) =>
    ApiBaseResponse.fromJson(json.decode(str));

String baseResponseToJson(ApiBaseResponse data) => json.encode(data.toJson());

class ApiBaseResponse {
  ApiBaseResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  final bool success;
  final String message;
  final dynamic data;

  factory ApiBaseResponse.fromJson(Map<String, dynamic> json) =>
      ApiBaseResponse(
        success: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": success,
        "message": message,
        "data": data,
      };
}
