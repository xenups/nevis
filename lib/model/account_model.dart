class AccountModel {
  int id;
  String username;
  String context;
  bool isSynced;
  DateTime password;
  String daysAgo;

  AccountModel({this.id,
    this.username,
    this.password,
  });

  AccountModel.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.username = json["user_name"];
    this.context = json["context"];
    this.password = json["created_date"];
  }
}
