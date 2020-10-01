import 'dart:convert';
import 'dart:async';
import 'package:business/blocs/inspeccion_detail_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:business/models/visita.dart';
import 'package:business/util/validate.dart';
import 'package:flutter/material.dart';

class NumberList {
  String number;
  int index;
  NumberList({this.number, this.index});
}

class RegisterInspeccion extends StatefulWidget {
  final String inspeccionID;
  RegisterInspeccion({Key key, @required this.inspeccionID}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RegisterInspeccionState();
  }

  /* @override
  _RegisterInspeccionState createState() => _RegisterInspeccionState(); */
}

class _RegisterInspeccionState extends State<RegisterInspeccion> {
  InspeccionDetailBloc _inspeccionDetailBloc;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Future<Visita> _futureInspeccion;
  Future<Visita> _futureVisita;
/*   String _atendido;
  String _direccion;
  String _nro_suministro;
  String _nro_puerta; */

  final TextEditingController _atendidoController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _nro_suministroController =
      TextEditingController();
  final TextEditingController _nro_puertaController = TextEditingController();
  final TextEditingController _detalleDistribucionController =
      TextEditingController();

  String dropDownValueUso;
  String dropDownValueOcupado;
  String dropDownValueMuro;
  String dropDownValueTecho;
  String dropDownValueInstElect;
  String dropDownValueInstSanit;
  String dropDownValueCalidConst;
  String dropDownValuePuertaTipo;
  String dropDownValuePuertaMaterial;
  String dropDownValuePuertaSistema;
  String dropDownValueVentanaMarco;
  String dropDownValueVentanaVidrio;
  String dropDownValueVentanaSistema;
  String dropDownValuePisoMaterial01;
  String dropDownValuePisoMaterial02;
  String dropDownValueRevestimientoTipo01;
  String dropDownValueRevestimientoTipo02;
  String dropDownValueViasADispone;
  String dropDownValueViasACalidad;
  String dropDownValueViasAEstadoC;
  String dropDownValueVeredasDispone;
  String dropDownValueVeredasCalidad;
  String dropDownValueVeredasEstadoC;
  String dropDownValueAlcantarilladoDispone;
  String dropDownValueAlcantarilladoCalidad;
  String dropDownValueAlcantarilladoEstadoC;
  String dropDownValueAguaPDispone;
  String dropDownValueAguaPCalidad;
  String dropDownValueAguaPEstadoC;
  String dropDownValueAlumbradoDispone;
  String dropDownValueAlumbradoCalidad;
  String dropDownValueAlumbradoEstadoC;
  String detalleDistribucion;

  List<String> itemsUso = [
    'Vivienda',
    'Comercio',
    'Oficina',
    'Desocupado',
    'Almacen',
    'Deposito',
    'Taller',
    'Otros usos'
  ];
  List<String> itemsOcupado = [
    'Propietario',
    'Inquilino',
    'Desocupado',
    'Terceros'
  ];
  List<String> itemsMuro = [
    'Adobe',
    'Pircado con mezcla de barro',
    'Drywall / Material liviano',
    'Albañilería (Ladrillo)',
    'Albañilería (Concreto)',
    'Albañilería (Calcáreo)',
    'Placas de Concreto',
    'De Piedra',
    'Otros'
  ];
  List<String> itemsTecho = [
    'Losa Aligerada de C°A° Unidireccional',
    'Losa Aligerada de C°A° Bidireccional',
    'Losas de C°A° inclinadas',
    'Calamina Metálica',
    'Fibrocemento sobre viguería metálica',
    'De Madera',
    'Caña o Torta de Barro',
    'Sin Techo',
    'Losa Aligerada y Madera Machihem.',
    'Otros'
  ];
  List<String> itemsInstElect = [
    'Sin Instalación',
    'Corriente Monofásica sin empotrar',
    'Corriente Monofásica empotrada ',
    'Corriente Trifásica',
    'Otros',
  ];
  List<String> itemsInstSanitaria = [
    'Sin Instalación',
    'Tuberías de agua fría y desagüe',
    'Tuberías de agua fría, caliente y desagüe',
    'Sist. de Bombeo de agua potable y desagüe',
    'Sist. de Bombeo de agua potable y desagüe por bombeo',
    'Otros',
  ];
  List<String> itemsCalidadConstruccion = [
    'Muy Bueno',
    'Bueno',
    'Regular',
    'Malo',
    'En construcción',
    'En proyecto',
  ];
  List<String> itemsRevestimiento = [
    'Pintura',
    'Tarrajeo y Pintura',
    'Cerámico',
    'Mayólica',
    'Porcelanato',
    'Otros'
  ];
  List<String> itemsPuertaTipo = [
    'Apanelada',
    'Maciza',
    'Contraplacada',
    'Otros',
  ];
  List<String> itemsPuertaMaterial = [
    'Fierro',
    'Madera',
    'Otros',
  ];

  List<String> itemsPuertaSitema = [
    'Corrediza',
    'Batiente',
    'Levadiza',
    'Otros',
  ];

  List<String> itemsVentanaMarco = [
    'Madera',
    'Aluminio',
    'Fierro',
    'Otros',
  ];
  List<String> itemsVentanaVidrio = [
    'Crudo',
    'Templado',
    'Semitemplado',
    'Otros',
  ];

  List<String> itemsVentanaSitema = [
    'Corrediza',
    'Batiente',
    'Otros',
  ];

  List<String> itemsPisos = [
    'Alfombra',
    'Bambú',
    'Cemento Bruñado',
    'Cemento Pulido',
    'Cerámica',
    'Cerámica Importada',
    'Ladrillo Pastelero',
    'Lajas',
    'Laminado',
    'Loseta Veneciana',
    'Loseta Vinílica',
    'Madera Machihembrada',
    'Mármol',
    'Mármol Importado',
    'Parquet',
    'Parquet de Primera',
    'Parquet Fino',
    'Porcelanato',
    'Porcelanato Importado',
    'Terrazo',
    'Tierra Compactada',
    'Otros',
  ];

  List<String> itemsInfraestructuraDisponible = [
    'Completas',
    'Incompletas',
    'No tiene',
    'En construcción',
    'En implementación',
  ];
  List<String> itemsInfraestructuraCalidad = [
    'Muy Alto',
    'Alto',
    'Medio',
    'Bajo',
    'Muy Bajo',
    'Otros'
  ];
  List<String> itemsInfraestructuraConservacion = [
    'Muy Bueno',
    'Bueno',
    'Regular',
    'Malo',
    'En Construcción',
    'En Proyecto'
  ];

  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "Propietario",
    ),
    NumberList(
      index: 2,
      number: "Inquilino",
    ),
    NumberList(
      index: 3,
      number: "Desocupado",
    ),
    NumberList(
      index: 4,
      number: "Terceros",
    )
  ];

  Map response = new Map();

  Future<Visita> submit(
      String inspeccionCodigo,
      String atendido,
      String direccion,
      String nro_suministro,
      String nro_puerta,
      String ocupado,
      String uso,
      String muros,
      String techos,
      String inst_electricas,
      String inst_sanitarias,
      String calidad_construccion,
      String puerta_tipo,
      String puerta_material,
      String puerta_sistema,
      String ventana_marco,
      String ventana_vidrio,
      String ventana_sistema,
      String piso_tipo,
      String piso_material,
      String revestimiento_tipo,
      String revestimiento_material,
      String vias_dispone,
      String vias_calidad,
      String vias_conservacion,
      String veredas_dispone,
      String veredas_calidad,
      String veredas_conservacion,
      String alcantarillado_dispone,
      String alcantarillado_calidad,
      String alcantarillado_conservacion,
      String aguapotable_dispone,
      String aguapotable_calidad,
      String aguapotable_conservacion,
      String alumbrado_dispone,
      String alumbrado_calidad,
      String alumbrado_conservacion,
      String distribucion_inmueble

      /*  String client,
      String address,
      String lightsupply_num,
      String door_num,
      String occupied,
      String type_use,
      String type_walls,
      String type_roofs,
      String electrical_inst,
      String sanitation_inst,
      String build_quality */
      ) async {
    final form = _formKey.currentState;

    final url = 'http://allemantperitos.com/appsgi/visita/insert';
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'inspeccion_id': widget.inspeccionID,
          'atendido': atendido,
          'direccion': direccion,
          'nro_suministro': nro_suministro,
          'nro_puerta': nro_puerta,
          'ocupado': ocupado,
          'uso': uso,
          'muros': muros,
          'techos': techos,
          'inst_electricas': inst_electricas,
          'inst_sanitarias': inst_sanitarias,
          'calidad_construccion': calidad_construccion,
          'puerta_tipo': puerta_tipo,
          'puerta_material': puerta_material,
          'puerta_sistema': puerta_sistema,
          'ventana_marco': ventana_marco,
          'ventana_vidrio': ventana_vidrio,
          'ventana_sistema': ventana_sistema,
          'piso_tipo': piso_tipo,
          'piso_material': piso_material,
          'revestimiento_tipo': revestimiento_tipo,
          'revestimiento_material': revestimiento_material,
          'vias_dispone': vias_dispone,
          'vias_calidad': vias_calidad,
          'vias_conservacion': vias_conservacion,
          'veredas_dispone': veredas_dispone,
          'veredas_calidad': veredas_calidad,
          'veredas_conservacion': veredas_conservacion,
          'alcantarillado_dispone': alcantarillado_dispone,
          'alcantarillado_calidad': alcantarillado_calidad,
          'alcantarillado_conservacion': alcantarillado_conservacion,
          'aguapotable_dispone': aguapotable_dispone,
          'aguapotable_calidad': aguapotable_calidad,
          'aguapotable_conservacion': aguapotable_conservacion,
          'alumbrado_dispone': alumbrado_dispone,
          'alumbrado_calidad': alumbrado_calidad,
          'alumbrado_conservacion': alumbrado_conservacion,
          'distribucion_inmueble': distribucion_inmueble
        }));
    if (response.statusCode == 200) {
      return Visita.fromJson(json.decode(response.body));
      // return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create inspeccion.');
    }
  }

/*   @override
  void initState() {
    super.initState();
    submit(widget.inspeccionID);
  }
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(20),
                        child: (_futureVisita == null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text("Atendido por: "),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 18.0),
                                      textInputAction: TextInputAction.done,
                                      controller: _atendidoController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            1.0, 10.0, 1.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('DIRECCIÓN INSPECCIÓN:'),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 18.0),
                                      textInputAction: TextInputAction.done,
                                      controller: _direccionController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            1.0, 10.0, 1.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: Icon(Icons.home),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('N° SUMINISTRO DE LUZ: '),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 18.0),
                                      controller: _nro_suministroController,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            1.0, 10.0, 1.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: Icon(Icons.power),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text('N° DE PUERTA: '),
                                    SizedBox(
                                      height: 7.0,
                                    ),
                                    TextFormField(
                                      style: TextStyle(fontSize: 18.0),
                                      controller: _nro_puertaController,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            1.0, 10.0, 1.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: Icon(Icons.receipt),
                                      ),
                                    ),
                                    SizedBox(height: 20.0),
                                    Center(
                                        child: Text(
                                      "DETALLE DE LA INSPECCIÓN",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "OCUPADO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnOcupado(
                                        itemsOcupado, "SELECCIONE"),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "USO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnUso(
                                        itemsUso, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Center(
                                        child: Text(
                                      "EDIFICACIÓN",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "MUROS",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnMuros(
                                        itemsMuro, "SELECCIONE"),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "TECHOS",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnTechos(
                                        itemsTecho, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "INSTALACIONES ELECTRICAS",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnInstElect(
                                        itemsInstElect, "SELECCIONE"),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "INSTALACIONES SANITARIAS",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnInstSanit(
                                        itemsInstSanitaria, "SELECCIONE"),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD DE CONSTRUCCIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnCalidadConst(
                                        itemsCalidadConstruccion, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Center(
                                        child: Text(
                                      "ACABADOS",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "PUERTAS",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "TIPO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnPuertaTipo(
                                        itemsPuertaTipo, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "MATERIAL",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnPuertaMaterial(
                                        itemsPuertaMaterial, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "SISTEMA",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnPuertaSistema(
                                        itemsPuertaSitema, "SELECCIONE"),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "VENTANAS",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "MARCO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVentanaMarco(
                                        itemsVentanaMarco, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "VIDRIO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVentanaVidrio(
                                        itemsVentanaVidrio, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "SISTEMA",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVentanaSistema(
                                        itemsVentanaSitema, "SELECCIONE"),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "PISO",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "MATERIAL",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnPisoMaterial01(
                                        itemsPisos, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnPisoMaterial02(
                                        itemsPisos, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "REVESTIMIENTO",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "TIPO",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnRevestimiento01(
                                        itemsRevestimiento, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnRevestimiento02(
                                        itemsRevestimiento, "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Center(
                                        child: Text(
                                      "INFRAESTRUCTURA SERVICIO",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )),
                                    SizedBox(height: 20),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "VIAS ASFALTADAS",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISPONE",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnViasAsfaltadasD(
                                        itemsInfraestructuraDisponible,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnViasAsfaltadasC(
                                        itemsInfraestructuraCalidad,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CONSERVACIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnViasAsfaltadasEstado(
                                        itemsInfraestructuraConservacion,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "VEREDAS",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISPONE",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVeredasD(
                                        itemsInfraestructuraDisponible,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVeredasC(
                                        itemsInfraestructuraCalidad,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CONSERVACIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnVeredasEstado(
                                        itemsInfraestructuraConservacion,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "ALCANTARILLADO",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISPONE",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlcantarillaD(
                                        itemsInfraestructuraDisponible,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlcantarillaC(
                                        itemsInfraestructuraCalidad,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CONSERVACIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlcantarillaEstado(
                                        itemsInfraestructuraConservacion,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "AGUA POTABLE",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISPONE",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAguaPotableD(
                                        itemsInfraestructuraDisponible,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAguaPotableC(
                                        itemsInfraestructuraCalidad,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CONSERVACIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAguaPotableEstado(
                                        itemsInfraestructuraConservacion,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          child: Text(
                                            "ALUMBRADO",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISPONE",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlumbradoD(
                                        itemsInfraestructuraDisponible,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CALIDAD",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlumbradoC(
                                        itemsInfraestructuraCalidad,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "CONSERVACIÓN",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    dropDownButtonsColumnAlumbradoEstado(
                                        itemsInfraestructuraConservacion,
                                        "SELECCIONE"),
                                    SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(
                                          "DISTRIBUCIÓN DEL INMUEBLE",
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      minLines: 3,
                                      maxLines: null,
                                      style: TextStyle(fontSize: 18.0),
                                      controller:
                                          _detalleDistribucionController,
                                      textInputAction: TextInputAction.done,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(
                                            1.0, 10.0, 1.0, 10.0),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        prefixIcon: Icon(Icons.home),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      child: new RaisedButton(
                                        onPressed: () {
                                          setState(() {
                                            _futureVisita = submit(
                                                widget.inspeccionID,
                                                _atendidoController.text,
                                                _direccionController.text,
                                                _nro_suministroController.text,
                                                _nro_puertaController.text,
                                                dropDownValueOcupado,
                                                dropDownValueUso,
                                                dropDownValueMuro,
                                                dropDownValueTecho,
                                                dropDownValueInstElect,
                                                dropDownValueInstSanit,
                                                dropDownValueCalidConst,
                                                dropDownValuePuertaTipo,
                                                dropDownValuePuertaMaterial,
                                                dropDownValuePuertaSistema,
                                                dropDownValueVentanaMarco,
                                                dropDownValueVentanaVidrio,
                                                dropDownValueVentanaSistema,
                                                dropDownValuePisoMaterial01,
                                                dropDownValuePisoMaterial02,
                                                dropDownValueRevestimientoTipo01,
                                                dropDownValueRevestimientoTipo02,
                                                dropDownValueViasADispone,
                                                dropDownValueViasACalidad,
                                                dropDownValueViasAEstadoC,
                                                dropDownValueVeredasDispone,
                                                dropDownValueVeredasCalidad,
                                                dropDownValueVeredasEstadoC,
                                                dropDownValueAlcantarilladoDispone,
                                                dropDownValueAlcantarilladoCalidad,
                                                dropDownValueAlcantarilladoEstadoC,
                                                dropDownValueAguaPDispone,
                                                dropDownValueAguaPCalidad,
                                                dropDownValueAguaPEstadoC,
                                                dropDownValueAlumbradoDispone,
                                                dropDownValueAlumbradoCalidad,
                                                dropDownValueAlumbradoEstadoC,
                                                _detalleDistribucionController
                                                    .text);
                                          });
                                        },
                                        color: Colors.blue,
                                        child: new Text(
                                          'GRABAR',
                                          style: new TextStyle(
                                              color: Colors.white,
                                              backgroundColor: Colors.blue),
                                        ),
                                      ),
                                    ),
                                  ])
                            : FutureBuilder<Visita>(
                                future: _futureVisita,
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data != null) {
                                      Navigator.pop(context);

                                    }
                                    /* Navigator.of(context).pushNamedAndRemoveUntil('/screen4', (Route<dynamic> route) => false); */

                                    //Navigator.pop(context);
                                    //Navigator.of(context).pushNamed('/home_page');
                                    /* Navigator.popUntil(context, ModalRoute.withName('/home_page'));
                                    Navigator.of(context).pushNamedAndRemoveUntil('/screen4', ModalRoute.withName('/screen1')); */

                                    //Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                    //Navigator.of(context).popUntil((route) => route.isFirst);

                                    //return Text(snapshot.data.success);
                                    //return Text("Se grabo Correctamente");
                                  } else if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return CircularProgressIndicator();
                                },
                              ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dropDownButtonsColumnCalidadConst(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueCalidConst = newValue;
                  });
                },
                value: dropDownValueCalidConst,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnViasAsfaltadasD(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueViasADispone = newValue;
                  });
                },
                value: dropDownValueViasADispone,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnViasAsfaltadasC(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueViasACalidad = newValue;
                  });
                },
                value: dropDownValueViasACalidad,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnViasAsfaltadasEstado(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueViasAEstadoC = newValue;
                  });
                },
                value: dropDownValueViasAEstadoC,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVeredasD(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVeredasDispone = newValue;
                  });
                },
                value: dropDownValueVeredasDispone,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVeredasC(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVeredasCalidad = newValue;
                  });
                },
                value: dropDownValueVeredasCalidad,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVeredasEstado(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVeredasEstadoC = newValue;
                  });
                },
                value: dropDownValueVeredasEstadoC,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlcantarillaD(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlcantarilladoDispone = newValue;
                  });
                },
                value: dropDownValueAlcantarilladoDispone,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlcantarillaC(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlcantarilladoCalidad = newValue;
                  });
                },
                value: dropDownValueAlcantarilladoCalidad,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlcantarillaEstado(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlcantarilladoEstadoC = newValue;
                  });
                },
                value: dropDownValueAlcantarilladoEstadoC,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAguaPotableD(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAguaPDispone = newValue;
                  });
                },
                value: dropDownValueAguaPDispone,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAguaPotableC(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAguaPCalidad = newValue;
                  });
                },
                value: dropDownValueAguaPCalidad,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAguaPotableEstado(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAguaPEstadoC = newValue;
                  });
                },
                value: dropDownValueAguaPEstadoC,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlumbradoD(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlumbradoDispone = newValue;
                  });
                },
                value: dropDownValueAlumbradoDispone,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlumbradoC(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlumbradoCalidad = newValue;
                  });
                },
                value: dropDownValueAlumbradoCalidad,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnAlumbradoEstado(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueAlumbradoEstadoC = newValue;
                  });
                },
                value: dropDownValueAlumbradoEstadoC,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnRevestimiento01(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueRevestimientoTipo01 = newValue;
                  });
                },
                value: dropDownValueRevestimientoTipo01,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnRevestimiento02(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueRevestimientoTipo02 = newValue;
                  });
                },
                value: dropDownValueRevestimientoTipo02,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnPisoMaterial01(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValuePisoMaterial01 = newValue;
                  });
                },
                value: dropDownValuePisoMaterial01,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnPisoMaterial02(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValuePisoMaterial02 = newValue;
                  });
                },
                value: dropDownValuePisoMaterial02,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVentanaMarco(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVentanaMarco = newValue;
                  });
                },
                value: dropDownValueVentanaMarco,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVentanaVidrio(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVentanaVidrio = newValue;
                  });
                },
                value: dropDownValueVentanaVidrio,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnVentanaSistema(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueVentanaSistema = newValue;
                  });
                },
                value: dropDownValueVentanaSistema,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnPuertaTipo(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValuePuertaTipo = newValue;
                  });
                },
                value: dropDownValuePuertaTipo,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnPuertaMaterial(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValuePuertaMaterial = newValue;
                  });
                },
                value: dropDownValuePuertaMaterial,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnPuertaSistema(
      List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValuePuertaSistema = newValue;
                  });
                },
                value: dropDownValuePuertaSistema,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnInstSanit(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueInstSanit = newValue;
                  });
                },
                value: dropDownValueInstSanit,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnInstElect(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueInstElect = newValue;
                  });
                },
                value: dropDownValueInstElect,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnTechos(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueTecho = newValue;
                  });
                },
                value: dropDownValueTecho,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnMuros(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueMuro = newValue;
                  });
                },
                value: dropDownValueMuro,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnOcupado(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueOcupado = newValue;
                  });
                },
                value: dropDownValueOcupado,
              ),
            )),
      ),
    );
  }

  Widget dropDownButtonsColumnUso(List<String> myData, String hinText) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, right: 0, bottom: 24, top: 0),
      child: Container(
        height: 50, //gives the height of the dropdown button
        width: MediaQuery.of(context)
            .size
            .width, //gives the width of the dropdown button
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        // padding: const EdgeInsets.symmetric(horizontal: 13), //you can include padding to control the menu items
        child: Theme(
            data: Theme.of(context).copyWith(
                canvasColor:
                    Colors.white, // background color for the dropdown items
                buttonTheme: ButtonTheme.of(context).copyWith(
                  alignedDropdown:
                      true, //If false (the default), then the dropdown's menu will be wider than its button.
                )),
            child: DropdownButtonHideUnderline(
              // to hide the default underline of the dropdown button
              child: DropdownButton<String>(
                isExpanded: true,
                /*  items: myData.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(), */
                items: myData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                }).toList(),
                hint: Text(
                  hinText,
                  style: TextStyle(color: Color(0xFF8B8B8B), fontSize: 15),
                ), // setting hint
                onChanged: (String newValue) {
                  setState(() {
                    dropDownValueUso = newValue;
                  });
                },
                value: dropDownValueUso,
              ),
            )),
      ),
    );
  }
}
