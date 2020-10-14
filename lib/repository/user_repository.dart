import 'dart:async';
import 'package:business/models/user.dart';
import 'package:business/network/api_base_helper.dart';

class UserRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  User _user;

  Future<User> getUsers() async {
    if (_user != null) return _user;

    final userList = await _helper.get("usuario/getUser");

    return userList;
  }

  Future<User> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User(usuId: "100", usuNombre: "Carlos"),
    );
  }
}
