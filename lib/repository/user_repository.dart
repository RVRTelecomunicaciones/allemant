import 'dart:async';
import 'package:business/models/user.dart';
import 'package:business/network/api_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  User _user;

  Future<User> getUsers(userID) async {
    if (_user != null) return _user;

    final userList = await _helper.get("usuario/getUserID/$userID");

    return User.fromJson(userList);
  }

  Future<User> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(usuId: "100", usuNombre: "Carlos"),
    );
  }
}
