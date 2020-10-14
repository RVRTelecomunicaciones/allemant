import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:business/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthRepository>(context),
              //authenticationRepository: authenticationRepository,
              //authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}
