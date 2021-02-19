import 'package:business/home_page.dart';
import 'package:business/widgets/Grid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var color = 0xff453658;
    return Flexible(
        child: GridView.builder(
      itemCount: grids.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) => MyCard(
        items: grids[index],
        press: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage())),
      ),
    ));
  }
}

class MyCard extends StatelessWidget {
  final MyListGrid items;
  final Function press;

  const MyCard({Key key, this.items, this.press}) : super(key: key);

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
                items.image,
                scale: 1.8,
              ),
              SizedBox(
                height: 14,
              ),
              Text(
                items.title,
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
