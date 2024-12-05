class UserModel {
  String name;
  String userName;
  int id;
  UserModel({
    required this.name,
    required this.userName,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'], userName: json['username'], id: json['id']);
  }
}
