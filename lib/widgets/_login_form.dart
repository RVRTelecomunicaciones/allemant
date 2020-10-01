import 'package:business/_home_page.dart';
import 'package:business/widgets/focusnode_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusNode _focus1 = FocusNode(); //Create first FocusNode
    FocusNode _focus2 = FocusNode(); //Create first FocusNode
    return SafeArea(
        top: false,
        child: Container(
            width: 330,
            child: Column(children: <Widget>[
              FocusNode_Event(
                prefixIcon: MaterialCommunityIcons.email_outline,
                hintText: "Email",
                focusName: _focus1,
                /* onEditCompleted: () {
                  FocusScope.of(context).requestFocus(_focus1);
                } */
              ),
              SizedBox(
                height: 20,
              ),
              FocusNode_Event(
                prefixIcon: MaterialCommunityIcons.key_outline,
                hintText: "Password",
                focusName: _focus2,
                /* onEditCompleted: () {
                  FocusScope.of(context).requestFocus(_focus2);
                } */
              ),
              SizedBox(height: 20),
              Align(
                alignment: Alignment.topRight,
                child: Text("Olvidó su contraseña?",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
              ),
              SizedBox(height: 20),
              Container(
                height: 55.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(HomePage.homerouteName);
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(21, 183, 255, 1),
                              Color.fromRGBO(0, 126, 255, 1)
                            ])),
                    child: Container(
                      constraints:
                          BoxConstraints(maxWidth: 200.0, minHeight: 55),
                      alignment: Alignment.center,
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80)),
                  padding: EdgeInsets.all(0.0),
                ),
              ),
              SizedBox(height: 30),
              Center(
                  child: Text("puede conectarse usando",
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                      child: RawMaterialButton(
                    elevation: 2.0,
                    child: Icon(
                      FontAwesome.facebook,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    constraints: BoxConstraints.tightFor(
                      width: 56.0,
                      height: 56.0,
                    ),
                    shape: CircleBorder(),
                    fillColor: Color.fromRGBO(57, 81, 133, 1),
                  )),
                  Expanded(
                      child: RawMaterialButton(
                    elevation: 2.0,
                    child: Icon(
                      FontAwesome.google_plus,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                    constraints: BoxConstraints.tightFor(
                      width: 56.0,
                      height: 56.0,
                    ),
                    shape: CircleBorder(),
                    fillColor: Colors.red,
                  )),
                ],
              )
            ])));
  }
}
