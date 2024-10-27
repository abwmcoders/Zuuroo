
class VerifyMeterResponse {
  final String status;
  final String message;
  final MeterData data;

  VerifyMeterResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyMeterResponse.fromJson(Map<String, dynamic> json) {
    return VerifyMeterResponse(
      status: json['status'],
      message: json['message'],
      data: MeterData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class MeterData {
  final bool invalid;
  final String name;
  final String address;

  MeterData({
    required this.invalid,
    required this.name,
    required this.address,
  });

  factory MeterData.fromJson(Map<String, dynamic> json) {
    return MeterData(
      invalid: json['invalid'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'invalid': invalid,
      'name': name,
      'address': address,
    };
  }
}
