class HistoryResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<HistoryData> data;

  HistoryResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    return HistoryResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<HistoryData>.from(
          json['data'].map((item) => HistoryData.fromJson(item))),
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

class HistoryData {
  final int id;
  final String userId;
  final String plan;
  final String purchase;
  final String countryCode;
  final String operatorCode;
  final String productCode;
  final String transferRef;
  final String phoneNumber;
  final String distribeRef;
  final int costPrice;
  final String sellingPrice;
  final String receiveValue;
  final String sendValue;
  final String receiveCurrency;
  final String commissionApplied;
  final String startedUtc;
  final String completedUtc;
  final String processingState;
  final String? createdAt;
  final String? updatedAt;

  HistoryData({
    required this.id,
    required this.userId,
    required this.plan,
    required this.purchase,
    required this.countryCode,
    required this.operatorCode,
    required this.productCode,
    required this.transferRef,
    required this.phoneNumber,
    required this.distribeRef,
    required this.costPrice,
    required this.sellingPrice,
    required this.receiveValue,
    required this.sendValue,
    required this.receiveCurrency,
    required this.commissionApplied,
    required this.startedUtc,
    required this.completedUtc,
    required this.processingState,
    this.createdAt,
    this.updatedAt,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) {
    return HistoryData(
      id: json['id'],
      userId: json['user_id'],
      plan: json['plan'],
      purchase: json['purchase'],
      countryCode: json['country_code'],
      operatorCode: json['operator_code'],
      productCode: json['product_code'],
      transferRef: json['transfer_ref'],
      phoneNumber: json['phone_number'],
      distribeRef: json['distribe_ref'],
      costPrice: json['cost_price'],
      sellingPrice: json['selling_price'],
      receiveValue: json['receive_value'],
      sendValue: json['send_value'],
      receiveCurrency: json['receive_currency'],
      commissionApplied: json['commission_applied'],
      startedUtc: json['startedUtc'],
      completedUtc: json['completedUtc'],
      processingState: json['processing_state'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'plan': plan,
      'purchase': purchase,
      'country_code': countryCode,
      'operator_code': operatorCode,
      'product_code': productCode,
      'transfer_ref': transferRef,
      'phone_number': phoneNumber,
      'distribe_ref': distribeRef,
      'cost_price': costPrice,
      'selling_price': sellingPrice,
      'receive_value': receiveValue,
      'send_value': sendValue,
      'receive_currency': receiveCurrency,
      'commission_applied': commissionApplied,
      'startedUtc': startedUtc,
      'completedUtc': completedUtc,
      'processing_state': processingState,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
