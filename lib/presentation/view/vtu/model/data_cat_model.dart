class DataCategoryResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<DataCategory> data;

  DataCategoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DataCategoryResponse.fromJson(Map<String, dynamic> json) {
    return DataCategoryResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => DataCategory.fromJson(item))
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

class DataCategory {
  final int id;
  final String operatorCode;
  final String categoryCode;
  final String categoryName;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  DataCategory({
    required this.id,
    required this.operatorCode,
    required this.categoryCode,
    required this.categoryName,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory DataCategory.fromJson(Map<String, dynamic> json) {
    return DataCategory(
      id: json['id'],
      operatorCode: json['operator_code'],
      categoryCode: json['category_code'],
      categoryName: json['category_name'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'operator_code': operatorCode,
      'category_code': categoryCode,
      'category_name': categoryName,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
