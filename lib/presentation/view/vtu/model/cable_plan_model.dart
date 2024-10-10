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
  final int id;
  final String plan;
  final String price;
  final List<String> channels;
  final String providerCode;
  final String createdAt;
  final String updatedAt;

  CablePlan({
    required this.id,
    required this.plan,
    required this.price,
    required this.channels,
    required this.providerCode,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CablePlan.fromJson(Map<String, dynamic> json) {
    return CablePlan(
      id: json['id'],
      plan: json['plan'],
      price: json['price'],
      channels: List<String>.from(json['channels']),
      providerCode: json['provider_code'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan': plan,
      'price': price,
      'channels': channels,
      'provider_code': providerCode,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
