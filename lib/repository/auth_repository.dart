import 'dart:async';
import 'dart:convert';
import 'package:business/models/api_model.dart';
import 'package:business/models/user.dart';
import 'package:business/models/useresponse.dart';
import 'package:meta/meta.dart';
import 'package:business/network/api_base_helper.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  ApiBaseHelper _helper = ApiBaseHelper();
  static AuthRepository _instance = AuthRepository();
  static AuthRepository get instance => _instance;

  Future<void> authenticate({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    UserLogin userLogin = UserLogin(username: username, password: password);

    final response =
        await _helper.post("usuario/logInApp", userLogin.toDatabaseJson());
    _controller.add(AuthenticationStatus.authenticated);
    /*  User user =
        User(usuId: response.user.usuId, usuNombre: response.user.usuNombre); */
    print(response);
    //return user;
    return Useresponse.fromJson(response);
  }

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
