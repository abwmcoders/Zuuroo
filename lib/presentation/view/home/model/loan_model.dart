class LoanLimitResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<LoanLimit> data;

  LoanLimitResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory LoanLimitResponse.fromJson(Map<String, dynamic> json) {
    return LoanLimitResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => LoanLimit.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class LoanLimit {
  final int id;
  final String labelName;
  final String percentage;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  LoanLimit({
    required this.id,
    required this.labelName,
    required this.percentage,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LoanLimit.fromJson(Map<String, dynamic> json) {
    return LoanLimit(
      id: json['id'],
      labelName: json['labelName'],
      percentage: json['percentage'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'labelName': labelName,
      'percentage': percentage,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
