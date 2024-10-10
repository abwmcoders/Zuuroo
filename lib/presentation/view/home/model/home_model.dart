class HomeModel {
  final String message;
  final Data data;

  HomeModel({
    required this.message,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final Wallet wallet;
  final List<dynamic> totalFund;
  final List<Record> record;
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
      totalFund: json['TotalFund'],
      record: List<Record>.from(json['Record'].map((x) => Record.fromJson(x))),
      recurring: json['Recurring'],
      outLoan: json['OutLoan'],
      totalSpend: json['TotalSpend'],
      user: User.fromJson(json['user']),
    );
  }
}

class Wallet {
  final int id;
  final String userId;
  final String email;
  final String balance;
  final String loanBalance;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
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

class User {
  final String username;
  final String name;
  final String email;
  final String address;
  final String dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String country;

  User({
    required this.username,
    required this.name,
    required this.email,
    required this.address,
    required this.dateOfBirth,
    required this.gender,
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
}
