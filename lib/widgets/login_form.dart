import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            SizedBox(height: 30),
            Center(
                child: Text("puede conectarse usando",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center)),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: RawMaterialButton(
                  elevation: 2.0,
                  child: Icon(
                    FontAwesome.facebook,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  constraints: BoxConstraints.tightFor(
                    width: 56.0,
                    height: 56.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: Color.fromRGBO(57, 81, 133, 1),
                )),
                Expanded(
                    child: RawMaterialButton(
                  elevation: 2.0,
                  child: Icon(
                    FontAwesome.google_plus,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                  constraints: BoxConstraints.tightFor(
                    width: 56.0,
                    height: 56.0,
                  ),
                  shape: CircleBorder(),
                  fillColor: Colors.red,
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextFormField(
          key: const Key('inputUsuario'),
          style: TextStyle(color: Colors.blue),
          onChanged: (username) =>
              context.bloc<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
              errorText: state.username.invalid ? 'invalid username' : null,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Icon(
                  MaterialCommunityIcons.email_outline,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue))),
        );
        /* TextField(
          key: const Key('inputUsuario'),
          onChanged: (username) =>
              context.bloc<LoginBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'username',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        ); */
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Column(
          children: <Widget>[
            TextFormField(
              style: TextStyle(color: Colors.blue, fontSize: 16.0),
              onChanged: (password) =>
                  context.bloc<LoginBloc>().add(LoginPasswordChanged(password)),
              obscureText: true,
              decoration: InputDecoration(
                  hintText: "Password",
                  errorText: state.password.invalid ? 'invalid password' : null,
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(FontAwesome.key),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.blue))),
            )
          ],
        );

        /* return TextField(
          key: const Key('inputContraseña'),
          onChanged: (password) =>
              context.bloc<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        ); */
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : Container(
                height: 55.0,
                child: RaisedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  onPressed: state.status.isValidated
                      ? () {
                          context.bloc<LoginBloc>().add(const LoginSubmitted());
                        }
                      : null,
                  child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(21, 183, 255, 1),
                              Color.fromRGBO(0, 126, 255, 1)
                            ])),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200.0, minHeight: 55),
                      alignment: Alignment.center,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  padding: EdgeInsets.all(0.0),
                ));
        /* RaisedButton(
                key: const Key('loginForm_continue_raisedButton'),
                child: const Text('Login'),
                onPressed: state.status.isValidated
                    ? () {
                        context.bloc<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
              ); */
      },
    );
  }
}
