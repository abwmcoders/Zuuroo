class VerifyIUCResponse {
  final bool status;
  final String message;
  final IUCData data;

  VerifyIUCResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory method to create an instance from JSON
  factory VerifyIUCResponse.fromJson(Map<String, dynamic> json) {
    return VerifyIUCResponse(
      status: json['status'].toString() == 'true', // Convert to boolean
      message: json['message'],
      data: IUCData.fromJson(json['data']),
    );
  }
}

class IUCData {
  final bool invalid;
  final String name;

  IUCData({
    required this.invalid,
    required this.name,
  });

  // Factory method to create an instance from JSON
  factory IUCData.fromJson(Map<String, dynamic> json) {
    return IUCData(
      invalid: json['invalid'],
      name: json['name'],
    );
  }
}
