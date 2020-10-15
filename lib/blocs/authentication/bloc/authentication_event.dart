part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  //final User user;
  const AuthenticationStatusChanged(this.status);

  @override
  List<Object> get props => [status];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;

  const AuthenticationUserChanged({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: $user.usuNombre.toString() }';
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
