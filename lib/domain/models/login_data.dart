class LoginData {
  String username;
  String password;

  LoginData({this.username, this.password});

  LoginData.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }

  @override
  String toString() {
    return 'LoginData{username: $username, password: $password}';
  }
}