class HomeModel {
  final String message;
  final Data data;

  HomeModel({required this.message, required this.data});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': data.toJson(),
    };
  }
}

class Data {
  final Wallet wallet;
  final List<dynamic> totalFund;
  final List<dynamic> record;
  final List<dynamic> recurring;
  final List<dynamic> outLoan;
  final List<dynamic> totalSpend;
  final User user;

  Data({
    required this.wallet,
    required this.totalFund,
    required this.record,
    required this.recurring,
    required this.outLoan,
    required this.totalSpend,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      wallet: Wallet.fromJson(json['wallet']),
      totalFund: json['TotalFund'] ?? [],
      record: json['Record'] ?? [],
      recurring: json['Recurring'] ?? [],
      outLoan: json['OutLoan'] ?? [],
      totalSpend: json['TotalSpend'] ?? [],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wallet': wallet.toJson(),
      'TotalFund': totalFund,
      'Record': record,
      'Recurring': recurring,
      'OutLoan': outLoan,
      'TotalSpend': totalSpend,
      'user': user.toJson(),
    };
  }
}

class Wallet {
  final int id;
  final String userId;
  final String email;
  final String balance;
  final String loanBalance;
  final DateTime createdAt;
  final DateTime updatedAt;

  Wallet({
    required this.id,
    required this.userId,
    required this.email,
    required this.balance,
    required this.loanBalance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      id: json['id'],
      userId: json['user_id'],
      email: json['email'],
      balance: json['balance'],
      loanBalance: json['loan_balance'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'email': email,
      'balance': balance,
      'loan_balance': loanBalance,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final String username;
  final String name;
  final String email;
  final String? address;
  final String? dateOfBirth;
  final String? gender;
  final String phoneNumber;
  final String country;

  User({
    required this.username,
    required this.name,
    required this.email,
    this.address,
    this.dateOfBirth,
    this.gender,
    required this.phoneNumber,
    required this.country,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      phoneNumber: json['phone_number'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'address': address,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'phone_number': phoneNumber,
      'country': country,
    };
  }
}



class Record {
  final int id;
  final String resReference;
  final String userName;
  final String userEmail;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String bankCode;
  final String accountStatus;
  final String createdAt;
  final String updatedAt;

  Record({
    required this.id,
    required this.resReference,
    required this.userName,
    required this.userEmail,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.bankCode,
    required this.accountStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Record.fromJson(Map<String, dynamic> json) {
    return Record(
      id: json['id'],
      resReference: json['res_reference'],
      userName: json['user_name'],
      userEmail: json['user_email'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      bankName: json['bank_name'],
      bankCode: json['bank_code'],
      accountStatus: json['account_status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
