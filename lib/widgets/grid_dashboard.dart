import 'package:business/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class GridDashboard extends StatelessWidget {

  class MyListGrid {
    final String title,image;
    final Int id;

    MyListGrid({
      this.title,
      this.image,
      this.id
    });

    List<MyListGrid> grids = [
      MyListGrid(id: 1, title: "Interiores", ),

    ]

    
  }
  Items item1 = new Items(
      title: "Interiores",
      subtitle: "Caracteristicas del inmueble",
      event: "3 Events",
      img: "assets/images/menu/interior.png");
  Items item2 = new Items(
    title: "Exteriores",
    subtitle: "Fachada del inmueble",
    event: "4 Items",
    img: "assets/images/menu/casita.png",
  );
  Items item3 = new Items(
    title: "Vehiculos",
    subtitle: "Caractesticas del vehiculo",
    event: "",
    img: "assets/images/menu/vehiculo.png",
  );
  Items item4 = new Items(
    title: "Maquinarias",
    subtitle: "Caracteristicas de la maquinaria",
    event: "",
    img: "assets/images/menu/machine.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];

    
    var color = 0xff453658;
    return Flexible(
      child: GridView.builder(
        itemCount: ,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => MyCard(),
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          children: myList.map((data) {
            return MyCard();
          }).toList()),
    );
  }
}

class MyCard extends StatelessWidget {
  final Items items;
  const MyCard({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        },
        splashColor: Colors.yellow,
        focusColor: Colors.amber,
        highlightColor: Colors.greenAccent,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                data.img,
                scale: 1.8,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                data.title,
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;
  Items({this.title, this.subtitle, this.event, this.img});
}
