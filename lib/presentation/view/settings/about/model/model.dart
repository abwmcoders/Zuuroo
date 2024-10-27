class AboutResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<About> data;

  AboutResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory AboutResponse.fromJson(Map<String, dynamic> json) {
    return AboutResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List).map((item) => About.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((about) => about.toJson()).toList(),
    };
  }
}

class About {
  final int id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  About({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
