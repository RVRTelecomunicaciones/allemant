import 'package:business/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:business/widgets/grid_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeMenu extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeMenu());
  }

  HomeMenu({Key key}) : super(key: key);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFFF5F5F5),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        //drawer: MainDrawer(),
        body: Padding(
          padding:
              EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
          child: Container(
            height: size.height,
            child: Column(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "ALLEMANT PERITOS",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "Menu",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GridDashboard()
            ]),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: UserAccountsDrawerHeader(
                  accountName: Text(
                      context.bloc<AuthenticationBloc>().state.user.usuNombre),
                  currentAccountPicture: CircleAvatar(
                    radius: 40.0,
                    backgroundImage: AssetImage('images/person/user.jpg'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                ),
                title: Text('Registrados'),
                onTap: () {
                  //ProfileScreen(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurar'),
                onTap: () {
                  //SettingScreen(context);
                },
              ),
              ListTile(
                leading: Icon(FontAwesome.sign_out),
                title: Text('Logout'),
                onTap: () {
                  context
                      .bloc<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              ),
            ],
          ),
        ),
        //bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
