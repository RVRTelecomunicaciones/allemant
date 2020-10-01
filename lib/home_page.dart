import 'package:business/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:business/widgets/inspeccion_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.25;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
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
        body: Container(
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
            InspeccionView(mySize: size, myCategoryHeight: categoryHeight)
          ]),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: UserAccountsDrawerHeader(
                  accountName:
                      Text(context.bloc<AuthenticationBloc>().state.user.id),
                  accountEmail: Text("congnghe4@thangloigroup.vn"),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('images/person/person_1.png'),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                ),
                title: Text('Thông tin cá nhân'),
                onTap: () {
                  //ProfileScreen(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Cài đặt'),
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
