class VerifyIucResponse {
  final bool success;
  final int statusCode;
  final VerifyIucData data;
  final String message;

  VerifyIucResponse({
    required this.success,
    required this.statusCode,
    required this.data,
    required this.message,
  });

  factory VerifyIucResponse.fromJson(Map<String, dynamic> json) {
    return VerifyIucResponse(
      success: json['success'],
      statusCode: json['statusCode'],
      data: VerifyIucData.fromJson(json['data']),
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

class VerifyIucData {
  final String iucNumber;
  final String customerName;
  final String customerNumber;
  final String serviceID;

  VerifyIucData({
    required this.iucNumber,
    required this.customerName,
    required this.customerNumber,
    required this.serviceID,
  });

  factory VerifyIucData.fromJson(Map<String, dynamic> json) {
    return VerifyIucData(
      iucNumber: json['iucNumber'],
      customerName: json['customerName'],
      customerNumber: json['customerNumber'],
      serviceID: json['serviceID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iucNumber': iucNumber,
      'customerName': customerName,
      'customerNumber': customerNumber,
      'serviceID': serviceID,
    };
  }
}
