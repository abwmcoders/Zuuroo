class CableResponse {
  bool? status;
  int? statusCode;
  String? message;
  List<CableData>? data;

  CableResponse({this.status, this.statusCode, this.message, this.data});

  factory CableResponse.fromJson(Map<String, dynamic> json) {
    return CableResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List)
              .map((i) => CableData.fromJson(i))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data != null ? data!.map((v) => v.toJson()).toList() : null,
    };
  }
}

class CableData {
  int? id;
  String? providerName;
  String? providerCode;
  String? countryCode;
  String? status;
  String? createdAt;
  String? updatedAt;

  CableData({
    this.id,
    this.providerName,
    this.providerCode,
    this.countryCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CableData.fromJson(Map<String, dynamic> json) {
    return CableData(
      id: json['id'],
      providerName: json['provider_name'],
      providerCode: json['provider_code'],
      countryCode: json['country_code'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider_name': providerName,
      'provider_code': providerCode,
      'country_code': countryCode,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
