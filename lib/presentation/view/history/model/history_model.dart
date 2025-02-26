// class HistoryResponse {
//   final bool status;
//   final int statusCode;
//   final String message;
//   final List<HistoryData> data;

//   HistoryResponse({
//     required this.status,
//     required this.statusCode,
//     required this.message,
//     required this.data,
//   });

//   factory HistoryResponse.fromJson(Map<String, dynamic> json) {
//     return HistoryResponse(
//       status: json['status'],
//       statusCode: json['statusCode'],
//       message: json['message'],
//       data: List<HistoryData>.from(
//           json['data'].map((item) => HistoryData.fromJson(item))),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'status': status,
//       'statusCode': statusCode,
//       'message': message,
//       'data': data.map((item) => item.toJson()).toList(),
//     };
//   }
// }

// class HistoryData {
//   final int id;
//   final String userId;
//   final String plan;
//   final String purchase;
//   final String countryCode;
//   final String operatorCode;
//   final String productCode;
//   final String transferRef;
//   final String phoneNumber;
//   final String distribeRef;
//   final int costPrice;
//   final String sellingPrice;
//   final String receiveValue;
//   final String sendValue;
//   final String receiveCurrency;
//   final String commissionApplied;
//   final String startedUtc;
//   final String completedUtc;
//   final String processingState;
//   final String? createdAt;
//   final String? updatedAt;

//   HistoryData({
//     required this.id,
//     required this.userId,
//     required this.plan,
//     required this.purchase,
//     required this.countryCode,
//     required this.operatorCode,
//     required this.productCode,
//     required this.transferRef,
//     required this.phoneNumber,
//     required this.distribeRef,
//     required this.costPrice,
//     required this.sellingPrice,
//     required this.receiveValue,
//     required this.sendValue,
//     required this.receiveCurrency,
//     required this.commissionApplied,
//     required this.startedUtc,
//     required this.completedUtc,
//     required this.processingState,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory HistoryData.fromJson(Map<String, dynamic> json) {
//     return HistoryData(
//       id: json['id'],
//       userId: json['user_id'],
//       plan: json['plan'],
//       purchase: json['purchase'],
//       countryCode: json['country_code'],
//       operatorCode: json['operator_code'],
//       productCode: json['product_code'],
//       transferRef: json['transfer_ref'],
//       phoneNumber: json['phone_number'],
//       distribeRef: json['distribe_ref'],
//       costPrice: json['cost_price'],
//       sellingPrice: json['selling_price'],
//       receiveValue: json['receive_value'],
//       sendValue: json['send_value'],
//       receiveCurrency: json['receive_currency'],
//       commissionApplied: json['commission_applied'],
//       startedUtc: json['startedUtc'],
//       completedUtc: json['completedUtc'],
//       processingState: json['processing_state'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'plan': plan,
//       'purchase': purchase,
//       'country_code': countryCode,
//       'operator_code': operatorCode,
//       'product_code': productCode,
//       'transfer_ref': transferRef,
//       'phone_number': phoneNumber,
//       'distribe_ref': distribeRef,
//       'cost_price': costPrice,
//       'selling_price': sellingPrice,
//       'receive_value': receiveValue,
//       'send_value': sendValue,
//       'receive_currency': receiveCurrency,
//       'commission_applied': commissionApplied,
//       'startedUtc': startedUtc,
//       'completedUtc': completedUtc,
//       'processing_state': processingState,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }

import 'dart:convert';

class HistoryResponse {
  final bool? status;
  final int? statusCode;
  final String? message;
  final List<HistoryData> data;

  HistoryResponse({
    this.status,
    this.statusCode,
    this.message,
    required this.data,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    var dataMap = json['data'] as List<dynamic>;
    List<HistoryData> historyDataMap = [];
    dataMap.forEach((value) {
      historyDataMap.add(HistoryData.fromJson(value));
    });
    // dataMap.forEach((key, value) {
    //   historyDataMap[key] = HistoryData.fromJson(value);
    // });

    return HistoryResponse(
      status: json['status'] ?? true,
      statusCode: json['statusCode'] ?? 200,
      message: json['message'] ?? "",
      data: historyDataMap,
    );
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
  final double costPrice;
  final String sellingPrice;
  final String receiveValue;
  final String sendValue;
  final String receiveCurrency;
  final String commissionApplied;
  final DateTime startedUtc;
  final DateTime completedUtc;
  final String processingState;
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
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
      costPrice: json['cost_price'].toDouble(),
      sellingPrice: json['selling_price'],
      receiveValue: json['receive_value'],
      sendValue: json['send_value'],
      receiveCurrency: json['receive_currency'],
      commissionApplied: json['commission_applied'],
      startedUtc: DateTime.parse(json['startedUtc']),
      completedUtc: DateTime.parse(json['completedUtc']),
      processingState: json['processing_state'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Example usage:
void main() {
  String jsonResponse = '''{
      "status": true,
      "statusCode": 200,
      "message": "Request completed successfully",
      "data": {
          "0": {
              "id": 88,
              "user_id": "45",
              "plan": "GLO Airtime VTU",
              "purchase": "Airtime",
              "country_code": "NG",
              "operator_code": "glo",
              "product_code": "VTU",
              "transfer_ref": "17254036924518552674486339",
              "phone_number": "08058863371",
              "distribe_ref": "2024090323487448910",
              "cost_price": 40,
              "selling_price": "39.2",
              "receive_value": "40.00",
              "send_value": "40",
              "receive_currency": "NGN",
              "commission_applied": "1.6",
              "startedUtc": "2024-09-03 23:48:14",
              "completedUtc": "2024-09-03 23:48:14",
              "processing_state": "delivered",
              "created_at": "2024-09-03T23:48:14.000000Z",
              "updated_at": "2024-09-03T23:48:14.000000Z"
          },
          "1": {
              "id": 87,
              "user_id": "45",
              "plan": "100.0MB",
              "purchase": "Data",
              "country_code": "NG",
              "operator_code": "airtel",
              "product_code": "220",
              "transfer_ref": "Data18378300698283280098",
              "phone_number": "09019613148",
              "distribe_ref": "ZR_847864",
              "cost_price": 50,
              "selling_price": "54",
              "receive_value": "100.0MB",
              "send_value": "100.0MB",
              "receive_currency": "NGN",
              "commission_applied": "0",
              "startedUtc": "2024-09-03 22:44:45",
              "completedUtc": "2024-09-03T23:44:42.254025",
              "processing_state": "successful",
              "created_at": "2024-09-03T22:44:45.000000Z",
              "updated_at": "2024-09-03T22:44:45.000000Z"
          }
      }
  }''';

  HistoryResponse response =
      HistoryResponse.fromJson(json.decode(jsonResponse));
  print(response.message);
}
