import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PopularRanking extends StatefulWidget {
  PopularRanking({Key key}) : super(key: key);

  @override
  _PopularRankingState createState() => _PopularRankingState();
}

class _PopularRankingState extends State<PopularRanking> {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: 265,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularTitle(),
          Expanded(
            child: PopularItems(),
          )
        ],
      ),
    );
  }
}

class PopularTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String level;
  String points;

  PopularTiles({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.level,
    @required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            decoration: BoxDecoration(boxShadow: []),
            child: Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Container(
                width: 170,
                height: 210,
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Center(
                              child: Image.asset(
                            'assets/images/' + imageUrl + ".png",
                            width: 130,
                            height: 140,
                          )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            name,
                            style: TextStyle(
                                color: Color(0xFF6e6e71),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 5),
                          child: Container(
                            height: 28,
                            width: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white70,
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFfae3e2),
                                  blurRadius: 25.0,
                                  offset: Offset(0.0, 0.75)                                  
                                ),
                              ]),
                            child: Icon(
                              FontAwesome5Solid.trophy, 
                              color:  Color(0xFFfb3132), 
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: Text(
                            level,
                            style: TextStyle(
                                color: Color(0xFF6e6e71),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 5),
                          child: Text(
                            points,
                            style: TextStyle(
                                color: Color(0xFF6e6e71),
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PopularTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Ranking Ventas",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "ver todos",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

class PopularItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        PopularTiles(
          name:"Javier",
          imageUrl: "person_1",
          points: "300.0",
          level: "Plata",
          ),
          PopularTiles(
          name:"Eduardo",
          imageUrl: "person_2",
          points: "230.0",
          level: "Plata",
          ),
          PopularTiles(
          name:"Peter",
          imageUrl: "person_3",
          points: "225.0",
          level: "Plata",
          ),
    
      ],
    );
  }
}