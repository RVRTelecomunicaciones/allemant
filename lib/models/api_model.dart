import 'dart:convert';

class UserLogin {
  String username;
  String password;

  UserLogin({this.username, this.password});

  Map<String, dynamic> toDatabaseJson() =>
      {"username": this.username, "password": this.password};
}

class Token {
  String token;

  Token({this.token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(token: json['token']);
  }
}

class MaDeXuat {
  String madexuat;

  MaDeXuat({this.madexuat});

  factory MaDeXuat.fromJson(Map<String, dynamic> data) {
    return MaDeXuat(madexuat: data['madexuat']);
  }
}
