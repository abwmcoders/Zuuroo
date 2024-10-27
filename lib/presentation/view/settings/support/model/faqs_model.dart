class FaqsResponse {
  final bool status;
  final int statusCode;
  final String message;
  final List<FaqData> data;

  FaqsResponse({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory FaqsResponse.fromJson(Map<String, dynamic> json) {
    return FaqsResponse(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: List<FaqData>.from(
        json['data'].map((item) => FaqData.fromJson(item)),
      ),
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

class FaqData {
  final int id;
  final String question;
  final String answer;
  // final DateTime? createdAt;
  // final DateTime? updatedAt;

  FaqData({
    required this.id,
    required this.question,
    required this.answer,
    // this.createdAt,
    // this.updatedAt,
  });

  factory FaqData.fromJson(Map<String, dynamic> json) {
    return FaqData(
      id: json['id'] ?? 0,
      question: json['question'] ?? "",
      answer: json['answer'] ?? "",
      // createdAt: DateTime.parse(json['created_at']) ,
      // updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? "",
      'question': question ?? "",
      'answer': answer ?? "",
      // 'created_at': createdAt !=null ? createdAt!.toIso8601String() : null,
      // 'updated_at': updatedAt != null ? updatedAt!.toIso8601String() : null,
    };
  }
}
