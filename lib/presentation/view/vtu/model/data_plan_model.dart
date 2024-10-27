class DataPlanResponse {
  final bool status;
  final String message;
  final List<DataPlan> data;

  DataPlanResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory constructor to parse JSON data
  factory DataPlanResponse.fromJson(Map<String, dynamic> json) {
    return DataPlanResponse(
      status: json['status'],
      message: json['message'],
      data: List<DataPlan>.from(
        json['data'].map((item) => DataPlan.fromJson(item)),
      ),
    );
  }

  // Convert the object to JSON (optional, for sending data)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class DataPlan {
  final int id;
  final String categoryCode;
  final String countryCode;
  final String operatorCode;
  final String productCode;
  final String productName;
  final int costPrice;
  final String productPrice;
  final String loanPrice;
  final String sendValue;
  final String sendCurrency;
  final String receiveValue;
  final String receiveCurrency;
  final String commissionRate;
  final String uatNumber;
  final String validity;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to parse JSON data
  factory DataPlan.fromJson(Map<String, dynamic> json) {
    return DataPlan(
      id: json['id'],
      categoryCode: json['category_code'],
      countryCode: json['country_code'],
      operatorCode: json['operator_code'],
      productCode: json['product_code'],
      productName: json['product_name'],
      costPrice: json['cost_price'],
      productPrice: json['product_price'],
      loanPrice: json['loan_price'],
      sendValue: json['send_value'],
      sendCurrency: json['send_currency'],
      receiveValue: json['receive_value'],
      receiveCurrency: json['receive_currency'],
      commissionRate: json['commission_rate'],
      uatNumber: json['uat_number'],
      validity: json['validity'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert the object to JSON (optional, for sending data)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_code': categoryCode,
      'country_code': countryCode,
      'operator_code': operatorCode,
      'product_code': productCode,
      'product_name': productName,
      'cost_price': costPrice,
      'product_price': productPrice,
      'loan_price': loanPrice,
      'send_value': sendValue,
      'send_currency': sendCurrency,
      'receive_value': receiveValue,
      'receive_currency': receiveCurrency,
      'commission_rate': commissionRate,
      'uat_number': uatNumber,
      'validity': validity,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
