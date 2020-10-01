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
        title: Text("Inspección"),
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
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("COORDINADOR",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            Text("COORDINACIÓN",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            Text("RIESGO",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            Text("FECHA SOLICITUD",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ),
                            Text("FECHA DE ENTREGA",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 12,
                            ), /*
                            Text("SOLICITANTE",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)) */
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(displayInspeccion.coordinadorNombre,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Text(displayInspeccion.coordinacionCorrelativo,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Text(displayInspeccion.riesgoNombre,
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab', fontSize: 13)),
                            SizedBox(
                              height: 12,
                            ),
                            Text(displayInspeccion.fechaSolicitud,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 12,
                            ),
                            Text(displayInspeccion.fechaEntrega,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 12,
                            ), /*
                            Text(displayInspeccion.solicitanteNombre,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 14,
                                )) */
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("SOLICITANTE",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(displayInspeccion.solicitanteNombre,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("CLIENTE",
                                  style: TextStyle(
                                      fontFamily: 'RobotoSlab',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 4,
                              ),
                              Text(displayInspeccion.clienteNombre,
                                  style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                  )),
                            ]),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("TIPO DE INSPECCIÓN",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(
                              height: 12,
                            ),
                            Text("PERITO",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(displayInspeccion.tipoInspeccionNombre,
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    color: Colors.black)),
                            SizedBox(
                              height: 12,
                            ),
                            Text(displayInspeccion.peritoNombre,
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    color: Colors.black)),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 12,
                    ),
                  ]),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("CONTACTO:",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(displayInspeccion.contactoNombre,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("DIRECCIÓN:",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(displayInspeccion.inspeccionDireccion,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("SERVICIOS:",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(displayInspeccion.servicioTipoNombre,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("OBSERVACIONES:",
                                style: TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Text(displayInspeccion.inspeccionObservacion,
                                style: TextStyle(
                                  fontFamily: 'RobotoSlab',
                                  fontSize: 13,
                                )),
                            SizedBox(
                              height: 14,
                            ),
                            /*  Container(
                              height: 50,
                              child: FlatButton(
                                color: Colors.blueAccent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('REALIZAR VISITA',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'RobotoSlab',
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => RegisterInspeccion(
                                          inspeccionID:
                                              displayInspeccion.inspeccionId)));
                                  /*   Navigator.of(context).push(
                                    MaterialPageRoute(
                                      fullscreenDialog:true,
                                      builder: (context) => InspeccionMenu(),
                                    )
                                  );  */
                                },
                              ),
                            ) */
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 55.0,
                          child: RaisedButton(
                            onPressed: () {},
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
                                  constraints: BoxConstraints(
                                      maxWidth: 160, minHeight: 55),
                                  //alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(FontAwesome.home,
                                          color: Colors.white),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "REGISTRAR",
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
                        SizedBox(
                          width: 10.00,
                        ),
                        Container(
                          height: 55.0,
                          child: RaisedButton(
                            onPressed: () {},
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
                                  constraints: BoxConstraints(
                                      maxWidth: 160, minHeight: 55),
                                  //alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                        /*   Material(
                                    color: Colors.blue,
                                    child: Row(children: <Widget>[
                                      InkWell(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: 16.0, left: 16.0),
                                          child: Container(
                                            width: 100,
                                            height: 50,
                                            child: Center(
                                              child: Text("INSPECCIÓN",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'RobotoSlab',
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        onTap: () {},
                                      ),
                                    ]),
                                  ),
                                  Material(
                                    color: Colors.blue,
                                    child: InkWell(
                                      child: Container(width: 100, height: 50),
                                      onTap: () {
                                        print("Wow! Ripple");
                                      },
                                    ),
                                  ) */
                      ]),
                ],
              ),
            ),
          ],
        )
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
