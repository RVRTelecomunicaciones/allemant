import 'dart:async';

import 'package:business/blocs/inspeccion_detail_bloc.dart';
import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_response.dart';
import 'package:business/widgets/inspeccion_detail_mapa.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:business/widgets/visita_form.dart';

class InspeccionDetail extends StatefulWidget {
  final String coordinacionID;

  const InspeccionDetail(this.coordinacionID);

  //InspeccionDetail({Key key}) : super(key: key);

  @override
  _InspeccionDetailState createState() => _InspeccionDetailState();
}

class _InspeccionDetailState extends State<InspeccionDetail> {
  InspeccionDetailBloc _inspeccionDetailBloc;
  final Location location = Location();

  LocationData _location;
  String _error;

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _inspeccionDetailBloc = InspeccionDetailBloc(widget.coordinacionID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(FontAwesome.arrow_left, color: Color(0xFF545D68)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "HOJA DE COORDINACIÓN",
          style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: 18,
              color: Color(0xFF545D68),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            _inspeccionDetailBloc.fetchInspeccionDetail(widget.coordinacionID),
        child: StreamBuilder<ApiResponse<Inspeccion>>(
          stream: _inspeccionDetailBloc.inspeccionDetailStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return ShowInspeccionDetail(
                      displayInspeccion: snapshot.data.data);
                  break;
                case Status.ERROR:
                  return Error(
                    errorMessage: snapshot.data.message,
                    onRetryPressed: () => _inspeccionDetailBloc
                        .fetchInspeccionDetail(widget.coordinacionID),
                  );
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inspeccionDetailBloc.dispose();
    super.dispose();
  }
}

class ShowInspeccionDetail extends StatelessWidget {
  final Inspeccion displayInspeccion;

  ShowInspeccionDetail({Key key, this.displayInspeccion}) : super(key: key);

  Widget changeColorRiesgo(tipo) {
    switch (tipo) {
      case 'BAJO':
        return Container(
          height: 30,
          width: 60,
          //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.green,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 10.0),
              ]),
          child: Center(
            child: Text(displayInspeccion.riesgoNombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //backgroundColor: Colors.green,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        );
        break;
      case 'MEDIO':
        return Container(
          height: 30,
          width: 60,
          //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.yellow,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 10.0),
              ]),
          child: Center(
            child: Text(displayInspeccion.riesgoNombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //backgroundColor: Colors.green,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        );
        break;
      case 'ALTO':
        return Container(
          height: 30,
          width: 60,
          //padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.red,
              boxShadow: [
                BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 10.0),
              ]),
          child: Center(
            child: Text(displayInspeccion.riesgoNombre,
                textAlign: TextAlign.center,
                style: TextStyle(
                    //backgroundColor: Colors.green,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        );

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(children: [
        ListView(
          //mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //InspeccionDetailMapa(),
            //showMap(),

            InkWell(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(80), blurRadius: 10.0),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(FontAwesome.user_o),
                          SizedBox(
                            width: 8,
                          ),
                          Text("COORDINADOR",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.coordinadorNombre.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesome.newspaper_o),
                          SizedBox(
                            width: 8,
                          ),
                          Text("COORDINACIÓN",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.coordinacionCorrelativo,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesome.exclamation_circle),
                          SizedBox(
                            width: 8,
                          ),
                          Text("RIESGO",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      changeColorRiesgo(displayInspeccion.riesgoNombre),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesome.calendar),
                          SizedBox(
                            width: 8,
                          ),
                          Text("FECHA DE SOLICITUD",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.fechaSolicitud,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesome.calendar),
                          SizedBox(
                            width: 8,
                          ),
                          Text("FECHA DE ENTREGA",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.fechaEntrega,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.black_tie),
                          SizedBox(
                            width: 10,
                          ),
                          Text("SOLICITANTE",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.solicitanteNombre,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.user),
                          SizedBox(
                            width: 10,
                          ),
                          Text("CLIENTE",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.clienteNombre,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(MaterialIcons.home),
                          SizedBox(
                            width: 10,
                          ),
                          Text("TIPO DE INSPECCIÓN",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.tipoInspeccionNombre.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome5.user_circle),
                          SizedBox(
                            width: 10,
                          ),
                          Text("PERITO",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.peritoNombre.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.male),
                          SizedBox(
                            width: 10,
                          ),
                          Text("CONTACTO",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.inspeccionContacto.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.road),
                          SizedBox(
                            width: 10,
                          ),
                          Text("DIRECCIÓN",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.inspeccionDireccion.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.window_maximize),
                          SizedBox(
                            width: 10,
                          ),
                          Text("SERVICIOS",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(displayInspeccion.servicioTipoNombre.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(FontAwesome.edit),
                          SizedBox(
                            width: 10,
                          ),
                          Text("OBSERVACIONES",
                              style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 14,
                                  color: Color.fromRGBO(233, 115, 44, 1),
                                  fontWeight: FontWeight.w900)),
                        ],
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                          displayInspeccion.inspeccionObservacion.toUpperCase(),
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color(0xFF545D68),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 14,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 42.0,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegisterInspeccion(
                                          inspeccionID:
                                              displayInspeccion.inspeccionId)));
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(18.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(255, 125, 0, 1),
                                            Color.fromRGBO(255, 0, 0, 1)
                                          ])),
                                  child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 160, minHeight: 55),
                                      //alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(FontAwesome.home,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Registrar",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                padding: EdgeInsets.all(0.0),
                              ),
                            ),
                            SizedBox(
                              width: 10.00,
                            ),
                            Container(
                              height: 42.0,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InspeccionMapa(
                                          latitud: double.parse(
                                              displayInspeccion
                                                  .inspeccionLatitud),
                                          longitud: double.parse(
                                              displayInspeccion
                                                  .inspeccionLongitud))));
                                },
                                child: Ink(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Color.fromRGBO(255, 125, 0, 1),
                                            Color.fromRGBO(255, 0, 0, 1)
                                          ])),
                                  child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 160, minHeight: 55),
                                      //alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(FontAwesome.map,
                                              color: Colors.white),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "UBICACIÓN",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      )),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(80)),
                                padding: EdgeInsets.all(0.0),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
              style: TextStyle(
//                color: Colors.white,
                  ),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
//              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}
