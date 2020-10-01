import 'package:business/level_page.dart';
import 'package:business/rank_page.dart';
import 'package:flutter/material.dart';


class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 10,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://i.vimeocdn.com/portrait/6200626_300x300',
                          ),
                          fit: BoxFit.fill
                      ),
                    ),
                  ),
                  Text(
                    'Mareena Thomas',
                    style: TextStyle(fontSize: 22,color: Colors.white,
                    ),
                  ),
                  Text(
                    'M.Thomas8@nuigalway.ie',
                    style: TextStyle(color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Niveles',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap:(){
              Navigator.of(context).pushNamed(LevelPage.routeLevelName);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_circle),
            title: Text(
              'Ranking',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
              onTap:(){
                Navigator.of(context).pushNamed(RankingPage.routeRankingName);
              }
          ),
        ],
      ),
    );
  }
}
