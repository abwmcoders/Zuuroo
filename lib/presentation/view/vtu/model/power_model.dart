class PowerModel {
  String? provider;
  String? code;
  String? providerLogoUrl;
  String? minAmount;

  PowerModel({this.provider, this.code, this.providerLogoUrl, this.minAmount});

  PowerModel.fromJson(Map<String, dynamic> json) {
    provider = json['provider'];
    code = json['code'];
    providerLogoUrl = json['providerLogoUrl'];
    minAmount = json['minAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provider'] = this.provider;
    data['code'] = this.code;
    data['providerLogoUrl'] = this.providerLogoUrl;
    data['minAmount'] = this.minAmount;
    return data;
  }
}
