class VerifyMeterNumberResponse {
  final bool success;
  final int statusCode;
  final VerifyMeterNumberData data;
  final String message;

  VerifyMeterNumberResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory VerifyMeterNumberResponse.fromJson(Map<String, dynamic> json) {
    return VerifyMeterNumberResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      data: VerifyMeterNumberData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'statusCode': statusCode,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class VerifyMeterNumberData {
  final String meterNumber;
  final String customerName;
  final String customerNumber;
  final String meterType;

  VerifyMeterNumberData({
    required this.meterNumber,
    required this.customerName,
    required this.customerNumber,
    required this.meterType,
  });

  factory VerifyMeterNumberData.fromJson(Map<String, dynamic> json) {
    return VerifyMeterNumberData(
      meterNumber: json['meterNumber'],
      customerName: json['customerName'],
      customerNumber: json['customerNumber'],
      meterType: json['meterType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'meterNumber': meterNumber,
      'customerName': customerName,
      'customerNumber': customerNumber,
      'meterType': meterType,
    };
  }
}
