class LoginData {
  String? username;
  String? password;

  LoginData(this.username, this.password);

  LoginData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
