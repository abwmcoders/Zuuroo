class AboutResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<CompanyData> data;

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
      data: List<CompanyData>.from(
        json['data'].map((item) => CompanyData.fromJson(item)),
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

class CompanyData {
  final int id;
  final String companyName;
  final String description;
  final String headquarters;
  final String contactEmail;
  final String contactPhone;
  final String websiteUrl;
  final List<String> servicesOffered;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  CompanyData({
    required this.id,
    required this.companyName,
    required this.description,
    required this.headquarters,
    required this.contactEmail,
    required this.contactPhone,
    required this.websiteUrl,
    required this.servicesOffered,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompanyData.fromJson(Map<String, dynamic> json) {
    return CompanyData(
      id: json['id'],
      companyName: json['company_name'],
      description: json['description'],
      headquarters: json['headquarters'],
      contactEmail: json['contact_email'],
      contactPhone: json['contact_phone'],
      websiteUrl: json['website_url'],
      servicesOffered: List<String>.from(json['services_offered']),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_name': companyName,
      'description': description,
      'headquarters': headquarters,
      'contact_email': contactEmail,
      'contact_phone': contactPhone,
      'website_url': websiteUrl,
      'services_offered': servicesOffered,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
