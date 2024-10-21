class TermsResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<TermData> data;

  TermsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory TermsResponse.fromJson(Map<String, dynamic> json) {
    return TermsResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<TermData>.from(
        json['data'].map((item) => TermData.fromJson(item)),
      ),
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

class TermData {
  final int id;
  final String writeUp;
  final String admin;
  final DateTime createdAt;
  final DateTime updatedAt;

  TermData({
    required this.id,
    required this.writeUp,
    required this.admin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TermData.fromJson(Map<String, dynamic> json) {
    return TermData(
      id: json['id'],
      writeUp: json['write_up'],
      admin: json['admin'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'write_up': writeUp,
      'admin': admin,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
