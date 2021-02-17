import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:business/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/authentication/bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
    return Scaffold(
        body: GestureDetector(
      //GESTUREDETECTOR NOS PERMITE PARA MINIMIZAR EL TECLADO AL HACER CLICK A CUALQUIER LADO USANDO ONTAP CON IOS
      /*  onTap: () {
            FocusScope.of(context).unfocus();
          }, */
      child: Container(
        height: double.infinity,
        width: double.infinity,
        //color: Colors.white, //PARA DETECTAR EL CLICK FUERA DEL FORM EN IOS.
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthRepository>(context),
              //authenticationRepository: authenticationRepository,
              //authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            );
          },
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
                            child: Image.asset("assets/images/page7.png",
                                scale: 5.0),
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                        ),
                        Center(
                            child: Text("Bienvenido!!",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
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
                    LoginForm()
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    ));
    /* Padding(
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
    );*/
  }
}
