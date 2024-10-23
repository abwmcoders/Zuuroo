class DataPlanResponse {
  final bool status;
  final String message;
  final List<DataPlan> data;

  DataPlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to create a DataPlanResponse from JSON
  factory DataPlanResponse.fromJson(Map<String, dynamic> json) {
    return DataPlanResponse(
      status: json['status'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => DataPlan.fromJson(item))
          .toList(),
    );
  }
}

class DataPlan {
  final int id;
  final String categoryCode;
  final String countryCode;
  final String operatorCode;
  final String productCode;
  final String productName;
  final double costPrice;
  final double productPrice;
  final double loanPrice;
  final double sendValue;
  final String sendCurrency;
  final double receiveValue;
  final String receiveCurrency;
  final double commissionRate;
  final String uatNumber;
  final String validity;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  DataPlan({
    required this.id,
    required this.categoryCode,
    required this.countryCode,
    required this.operatorCode,
    required this.productCode,
    required this.productName,
    required this.costPrice,
    required this.productPrice,
    required this.loanPrice,
    required this.sendValue,
    required this.sendCurrency,
    required this.receiveValue,
    required this.receiveCurrency,
    required this.commissionRate,
    required this.uatNumber,
    required this.validity,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to create a DataPlan from JSON
  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      id: json['id'] as int,
      categoryCode: json['category_code'] as String,
      countryCode: json['country_code'] as String,
      operatorCode: json['operator_code'] as String,
      productCode: json['product_code'] as String,
      productName: json['product_name'] as String,
      costPrice: (json['cost_price'] as num).toDouble(),
      productPrice: double.parse(json['product_price']),
      loanPrice: double.parse(json['loan_price']),
      sendValue: double.parse(json['send_value']),
      sendCurrency: json['send_currency'] as String,
      receiveValue: double.parse(json['receive_value']),
      receiveCurrency: json['receive_currency'] as String,
      commissionRate: double.parse(json['commission_rate']),
      uatNumber: json['uat_number'] as String,
      validity: json['validity'] as String,
      status: json['status'] as int,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}
