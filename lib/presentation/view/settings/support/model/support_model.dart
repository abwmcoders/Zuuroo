class SupportResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<SupportData> data;

  SupportResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory SupportResponse.fromJson(Map<String, dynamic> json) {
    return SupportResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<SupportData>.from(
        json['data'].map((item) => SupportData.fromJson(item)),
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

class SupportData {
  final int id;
  final String pageType;
  final String pageName;
  final String pageLink;
  final String pageIcon;
  final DateTime createdAt;
  final DateTime updatedAt;

  SupportData({
    required this.id,
    required this.pageType,
    required this.pageName,
    required this.pageLink,
    required this.pageIcon,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SupportData.fromJson(Map<String, dynamic> json) {
    return SupportData(
      id: json['id'],
      pageType: json['page_type'],
      pageName: json['page_name'],
      pageLink: json['page_link'],
      pageIcon: json['page_icon'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'page_type': pageType,
      'page_name': pageName,
      'page_link': pageLink,
      'page_icon': pageIcon,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
