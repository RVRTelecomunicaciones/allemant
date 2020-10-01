import 'dart:async';
import 'package:meta/meta.dart';
import 'package:business/network/api_base_helper.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  /* ApiBaseHelper _helper = ApiBaseHelper();
  static AuthRepository _instance = AuthRepository();
  static AuthRepository get instance => _instance;

  Future<String> authenticate(
      @required String username, @required String password) async {
    assert(username != null);
    assert(password != null);

    final Map<String, dynamic> authData = {
      "inputUsuario": username,
      "inputContraseña": password
    };
    final response = await _helper.post("usuario/logIn", authData);

    if (response.success) {
      return response;
    }
  } */
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<void> logIn({
    @required String username,
    @required String password,
  }) async {
    assert(username != null);
    assert(password != null);

    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
