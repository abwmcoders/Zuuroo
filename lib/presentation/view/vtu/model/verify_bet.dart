class VerifyBet {
  String? provider;
  String? customerId;
  String? firstName;
  String? lastName;
  String? userName;

  VerifyBet(
      {this.provider,
      this.customerId,
      this.firstName,
      this.lastName,
      this.userName});

  VerifyBet.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    customerId = json['customerId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['customerId'] = this.customerId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    return data;
  }
}
