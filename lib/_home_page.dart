import 'package:business/models/inspeccion_response.dart';
import 'package:business/widgets/BottomNavBarWidget.dart';
import 'package:business/widgets/PopularWidget.dart';
import 'package:business/widgets/custom_drawer.dart';
import 'package:business/widgets/inspeccion_list.dart';
import 'package:business/widgets/inspeccion_list_view.dart';
import 'package:business/widgets/inspeccion_tipo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const homerouteName = '/home_page';

  static const routeName = '/details_screen';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final InspeccionTipoScroller categoriesScroller = InspeccionTipoScroller();
  //bool closeTopContainer = false;
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
              leading: Icon(
                Icons.menu,
                color: Colors.black,
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
            )

            //bottomNavigationBar: BottomNavBarWidget(),
            ));
  }
}
