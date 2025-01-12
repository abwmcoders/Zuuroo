
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

class MeterModel {
  String? provider;
  String? customerName;
  String? number;
  String? address;
  String? type;

  MeterModel(
      {this.provider, this.customerName, this.number, this.address, this.type});

  MeterModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    customerName = json['Customer_Name'];
    number = json['number'];
    address = json['Address'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['Customer_Name'] = this.customerName;
    data['number'] = this.number;
    data['Address'] = this.address;
    data['type'] = this.type;
    return data;
  }
}
