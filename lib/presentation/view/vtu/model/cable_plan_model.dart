class CablePlanResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<CablePlan> data;

  CablePlanResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CablePlanResponse.fromJson(Map<String, dynamic> json) {
    return CablePlanResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<CablePlan>.from(
        json['data'].map((plan) => CablePlan.fromJson(plan)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data.map((plan) => plan.toJson()).toList(),
    };
  }
}

class CablePlan {
  int? id;
  String? plan;
  String? price;
  String? providerCode;
  String? createdAt;
  String? updatedAt;

  CablePlan(
      {this.id,
      this.plan,
      this.price,
      this.providerCode,
      this.createdAt,
      this.updatedAt});

  CablePlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    plan = json['plan'];
    price = json['price'];
    providerCode = json['provider_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['plan'] = this.plan;
    data['price'] = this.price;
    data['provider_code'] = this.providerCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
