import 'dart:async';
import 'package:business/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import 'package:business/models/password.dart';
import 'package:business/models/username.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authenticationRepository;
  //final AuthenticationBloc _authenticationBloc;
  LoginBloc({
    @required AuthRepository authenticationRepository,
    //@required AuthenticationBloc authenticationBloc,
  })  : assert(authenticationRepository != null),
        //assert(authenticationBloc != null),
        _authenticationRepository = authenticationRepository,
        //_authenticationBloc = authenticationBloc,
        super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.authenticate(
          username: state.username.value,
          password: state.password.value,
        );

        //_authenticationBloc.add(LoggedIn(user: user));

        yield state.copyWith(status: FormzStatus.submissionSuccess);
      } on Exception catch (_) {
        yield state.copyWith(status: FormzStatus.submissionFailure);
      }
    }
  }
}
