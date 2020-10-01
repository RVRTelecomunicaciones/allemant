import 'dart:async';

import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:business/_home_page.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:business/widgets/_login_form.dart';
import 'package:business/widgets/scroll_expandede_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  /* body: (
        bloc: _bloc,
        listener: (BuildContext context, LoginState state) {
          if (state is LoginError) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          }
          if (state is LoggedInState) {
            Navigator.of(context).pushNamed('/home');
          }
        },
        child: BlocBuilder<LoginBloc, BaseLogin>(
            bloc: _bloc,
            builder: (BuildContext context, BaseLoginState state) {
              return Form(
                key: _formKey,
                child: ScrollExpandContainer(
                  children: <Widget>[
                    Image.asset('assets/logo.png'),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(hintText: "Password"),
                      ),
                    ),
                    Spacer(),
                    if (state is LoginLoading)
                      CircularProgressIndicator()
                    else
                      RaisedButton(
                        onPressed: () {
                          var email = _emailController.text;
                          var password = _passwordController.text;

                          var event = GoLogin(email, password);

                          _bloc.add(event);
                        },
                        child: Text("Log in"),
                      ),
                    Spacer(),
                  ],
                ),
              );
            }),
      ), */

}

/* @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));

    return Scaffold(
        body: GestureDetector(
          //GESTUREDETECTOR NOS PERMITE PARA MINIMIZAR EL TECLADO AL HACER CLICK A CUALQUIER LADO USANDO ONTAP CON IOS
        /*   onTap: () {
            this._dismissKeyboard(context);
          }, */
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white, //PARA DETECTAR EL CLICK FUERA DEL FORM EN IOS.
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 50),
                          Center(
                            child: Container(
                              child:
                                  Image.asset("assets/images/page7.png", scale: 5.0),
                              padding: EdgeInsets.only(bottom: 20),
                            ),
                          ),
                          Center(
                              child: Text("Bienvenido!!",
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center)),
                          SizedBox(height: 10),
                          Center(
                              child: Text(
                                  "Inicie sesion para acceder a su cuenta",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal),
                                  textAlign: TextAlign.center)),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      //LoginForm()
                      
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ));
  } */
