import 'package:flutter/material.dart';

class MyListGrid {
  final String title, image;
  final int id;

  MyListGrid({this.title, this.image, this.id});
}

List<MyListGrid> grids = [
  MyListGrid(
      id: 1, title: "Interiores", image: "assets/images/menu/interior.png"),
  MyListGrid(
      id: 2, title: "Exteriores", image: "assets/images/menu/casita.png"),
  MyListGrid(
      id: 3, title: "Vehiculos", image: "assets/images/menu/vehiculo.png"),
  MyListGrid(
      id: 4, title: "Maquinarias", image: "assets/images/menu/machine.png"),
];
