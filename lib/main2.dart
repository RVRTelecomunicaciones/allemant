import 'package:business/blocs/bloc/login_bloc.dart';
import 'package:business/_home_page.dart';
import 'package:business/level_page.dart';
import 'package:business/_login_page.dart';
import 'package:business/rank_page.dart';
import 'package:business/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
          create: (_) => LoginBloc(authenticationRepository: AuthRepository()),
          child: HomePage(),
        ));
  }
}
