import 'package:business/app.dart';
import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:business/_home_page.dart';
import 'package:business/level_page.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:business/repository/user_repository.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App(
    authenticationRepository: AuthRepository(),
    userRepository: UserRepository(),
  ));
}

/*void main() => runApp(MyApp());

 class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            routes: {
              HomePage.homerouteName: (_) => HomePage(),
              RankingPage.routeRankingName: (_) => RankingPage(),
              LevelPage.routeLevelName: (_) => LevelPage()
            },
            home: BlocProvider(
              create: (_) =>
                  LoginBloc(authenticateRepository: AuthRepository()),
              child: HomePage(),
            ));
      },
    );
  }
}
 */
