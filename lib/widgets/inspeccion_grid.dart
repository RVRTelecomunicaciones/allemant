import 'package:flutter/material.dart';

class InspeccionMenu extends StatelessWidget {
  const InspeccionMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("DETALLES DE INSPECCIÓN"),
        backgroundColor: Colors.blueAccent[700],
      ),
      backgroundColor: Colors.blueAccent[200],
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(title: "OCUPACIÓN",),
            MyMenu(title: "EDIFICACIÓN",)
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.colorIcon});

  final String title;
  final IconData icon;
  final MaterialColor colorIcon;

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.blueAccent,
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                size: 70.0,
                color: colorIcon,
              ),
              Text(
                title,
                style: TextStyle(fontSize: 17.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
