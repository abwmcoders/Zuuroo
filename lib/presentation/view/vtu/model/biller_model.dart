class BillerResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<BillerData> data;

  BillerResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory BillerResponse.fromJson(Map<String, dynamic> json) {
    return BillerResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<BillerData>.from(
          json['data'].map((x) => BillerData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class BillerData {
  final int id;
  final String billerName;
  final String billerCode;
  final String countryCode;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  BillerData({
    required this.id,
    required this.billerName,
    required this.billerCode,
    required this.countryCode,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BillerData.fromJson(Map<String, dynamic> json) {
    return BillerData(
      id: json['id'],
      billerName: json['biller_name'],
      billerCode: json['biller_code'],
      countryCode: json['country_code'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'biller_name': billerName,
      'biller_code': billerCode,
      'country_code': countryCode,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
