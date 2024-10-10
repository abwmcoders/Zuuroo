class OperatorResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<OperatorModel> data;

  OperatorResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory OperatorResponse.fromJson(Map<String, dynamic> json) {
    return OperatorResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<OperatorModel>.from(
          json['data'].map((x) => OperatorModel.fromJson(x))),
    );
  }
}

class OperatorModel {
  final int id;
  final String countryCode;
  final String operatorName;
  final String operatorCode;
  final String validationRegex;
  final String logoUrl;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  OperatorModel({
    required this.id,
    required this.countryCode,
    required this.operatorName,
    required this.operatorCode,
    required this.validationRegex,
    required this.logoUrl,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    return OperatorModel(
      id: json['id'],
      countryCode: json['country_code'],
      operatorName: json['operator_name'],
      operatorCode: json['operator_code'],
      validationRegex: json['validation_regex'],
      logoUrl: json['logo_url'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
