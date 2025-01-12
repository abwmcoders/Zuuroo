class BetModel {
  String? provider;
  String? providerLogoUrl;
  String? minAmount;
  String? maxAmount;

  BetModel(
      {this.provider, this.providerLogoUrl, this.minAmount, this.maxAmount});

  BetModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    providerLogoUrl = json['providerLogoUrl'];
    minAmount = json['minAmount'];
    maxAmount = json['maxAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['providerLogoUrl'] = this.providerLogoUrl;
    data['minAmount'] = this.minAmount;
    data['maxAmount'] = this.maxAmount;
    return data;
  }
}
