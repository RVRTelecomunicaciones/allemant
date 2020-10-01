
import 'dart:convert';

List<Visita> inspeccionFromJson(String str) => new List<Visita>.from(json.decode(str).map((x) => Visita.fromJson(x)));

//String inspeccionToJson(List<Visita> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
String inspeccionToJson(Visita data) => json.encode(data.toJson());

class Visita {
  String inspeccion_codigo;
  String client;
  String address;
  String lightsupplyNum;
  String doorNum;
  String occupied;
  String typeUse;
  String typeWalls;
  String typeRoofs;
  String electricalInst;
  String sanitationInst;
  String buildQuality;

  Visita(
      {this.inspeccion_codigo,
        this.client,
      this.address,
      this.lightsupplyNum,
      this.doorNum,
      this.occupied,
      this.typeUse,
      this.typeWalls,
      this.typeRoofs,
      this.electricalInst,
      this.sanitationInst,
      this.buildQuality});

  Visita.fromJson(Map<String, dynamic> json) {
    inspeccion_codigo = json['inspeccion_codigo'];
    client = json['client'];
    address = json['address'];
    lightsupplyNum = json['lightsupply_num'];
    doorNum = json['door_num'];
    occupied = json['occupied'];
    typeUse = json['type_use'];
    typeWalls = json['type_walls'];
    typeRoofs = json['type_roofs'];
    electricalInst = json['electrical_inst'];
    sanitationInst = json['sanitation_inst'];
    buildQuality = json['build_quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inspeccion_codigo'] = this.inspeccion_codigo;
    data['client'] = this.client;
    data['address'] = this.address;
    data['lightsupply_num'] = this.lightsupplyNum;
    data['door_num'] = this.doorNum;
    data['occupied'] = this.occupied;
    data['type_use'] = this.typeUse;
    data['type_walls'] = this.typeWalls;
    data['type_roofs'] = this.typeRoofs;
    data['electrical_inst'] = this.electricalInst;
    data['sanitation_inst'] = this.sanitationInst;
    data['build_quality'] = this.buildQuality;
    return data;
  }
}