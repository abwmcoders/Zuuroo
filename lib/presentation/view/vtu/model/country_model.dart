class CountryResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<CountryModel> data;

  CountryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) {
    return CountryResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<CountryModel>.from(
          json['data'].map((x) => CountryModel.fromJson(x))),
    );
  }
}

class CountryModel {
  final int id;
  final String countryName;
  final String countryCode;
  final int isLoan;
  final String phoneCode;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  CountryModel({
    required this.id,
    required this.countryName,
    required this.countryCode,
    required this.isLoan,
    required this.phoneCode,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'],
      countryName: json['country_name'],
      countryCode: json['country_code'],
      isLoan: json['is_loan'],
      phoneCode: json['phone_code'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
