import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:business/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InspeccionMapa extends StatefulWidget {
  final double latitud;
  final double longitud;

  InspeccionMapa({Key key, @required this.latitud, @required this.longitud})
      : super(key: key);

  @override
  _InspeccionDetailMapaState createState() => _InspeccionDetailMapaState();
}

class _InspeccionDetailMapaState extends State<InspeccionMapa> {
  BitmapDescriptor pinLocationIcon;

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;

  //########GEOLOCATOR
  Position _currentPosition;
  StreamSubscription<Position> _positionStream;

  //######PERITO ICON
  BitmapDescriptor pinLocationUserIcon;
  BitmapDescriptor pinLocationCarIcon;

  static LatLng _initialPosition;

  Marker marker;

  Set<Marker> markers = {};

  Circle circle;

  Widget _child;

  final List<LatLng> markerLocations = [LatLng(-10.749204, -77.761335)];
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
    //setCustomMapPinUser();
    //_createMarker();
  }

  /// Calculate distance between two location
  Future<String> calculateDistance(
      LatLng firstLocation, LatLng secondLocation) async {
    Position youPosition;
    Position positionClient;

    // Start Location Marker
    Marker startMarker = Marker(
      markerId: MarkerId('$firstLocation'),
      position: LatLng(
        firstLocation.latitude,
        firstLocation.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Start',
        //snippet: _startAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    // Destination Location Marker
    Marker destinationMarker = Marker(
      markerId: MarkerId('$secondLocation'),
      position: LatLng(
        secondLocation.latitude,
        secondLocation.longitude,
      ),
      infoWindow: InfoWindow(
        title: 'Destino',
        //snippet: _destinationAddress,
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    // Adding the markers to the list
    markers.add(startMarker);
    markers.add(destinationMarker);

    Position _northeastCoordinates;
    Position _southwestCoordinates;

    // Calculating to check that
    // southwest coordinate <= northeast coordinate
    /* if (_currentPosition.latitude <= widget.latitud) {
      _southwestCoordinates = Position(_currentPositon);
      _northeastCoordinates = destinationCoordinates;
    } else {
      _southwestCoordinates = destinationCoordinates;
      _northeastCoordinates = startCoordinates;
    } */

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((secondLocation.latitude - firstLocation.latitude) * p) / 2 +
        c(firstLocation.latitude * p) *
            c(secondLocation.latitude * p) *
            (1 - c((secondLocation.longitude - firstLocation.longitude) * p)) /
            2;
    var distance = 12742 * asin(sqrt(a));

    if (distance < 1) {
      return (double.parse(distance.toStringAsFixed(3)) * 1000)
              .toString()
              .split(".")[0] +
          " metros";
    } else {
      return double.parse(distance.toStringAsFixed(2)).toString() + " km";
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  //ICONOS DE MARKER DE ACUERDO A LA PANTALLA
  Future<Uint8List> getBytesFromCanvas(double escala, urlAsset) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final ByteData datai = await rootBundle.load(urlAsset);
    var imaged = await loadImage(new Uint8List.view(datai.buffer));

    double width = ((imaged.width.toDouble() * escala).toInt()).toDouble();
    double height = ((imaged.height.toDouble() * escala).toInt()).toDouble();

    canvas.drawImageRect(
      imaged,
      Rect.fromLTRB(
          0.0, 0.0, imaged.width.toDouble(), imaged.height.toDouble()),
      Rect.fromLTRB(0.0, 0.0, width, height),
      new Paint(),
    );

    final img = await pictureRecorder
        .endRecording()
        .toImage(width.toInt(), height.toInt());
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data.buffer.asUint8List();
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  void _getCurrentLocation() async {
    Uint8List imageData = await getMarker();
    /* Uint8List imageData =
        await getBytesFromCanvas(1, 'assets/images/car_icon.png');
 */
    var localOptions =
        LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

    _positionStream = Geolocator()
        .getPositionStream(localOptions)
        .listen((Position position) {
      setState(() {
        print(position.latitude);
        _currentPosition = position;

        if (mapController != null) {
          mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(position.latitude, position.longitude),
                zoom: 18.0,
              ),
            ),
          );
        }

        updateMarkers(imageData);

        _child = mapWidget();
        /* _initialPosition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);
        print(_initialPosition);
 */
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');

    _controller.complete(controller);

    //PARA DISEÑO DEL MAPA
    controller.setMapStyle(value);

    //PARA ANIMAR LA ANIMACIÓN DE LA CAMARA DURANTE EL RECORRIDO
    mapController = controller;
  }

  void setCustomMapPinUser() async {
    pinLocationUserIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/markerUsuario5.png');
  }

  void setCustomMapPinCar() async {
    pinLocationCarIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/car_icon.png');
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  updateMarkers(Uint8List imageData) async {
    /* final markerIcon =
        await getBytesFromCanvas(1, 'assets/images/car_icon.png'); */
    /* var markers = Set<Marker>();
    markers.add(
      Marker(
          onTap: () {
            print('Tapped');
          },
          draggable: true,
          markerId: MarkerId('Tu'),
          position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
          rotation: _currentPosition.heading,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationUserIcon,
          infoWindow: InfoWindow(title: 'Tu'),
          onDragEnd: ((value) {})),
    ); */

    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
          rotation: _currentPosition.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: _currentPosition.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  /*  Set<Marker> _createMarker() {
    var markers = Set<Marker>();

    markers.add(
      Marker(
          onTap: () {
            print('Tapped');
          },
          draggable: true,
          markerId: MarkerId('Tu'),
          position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
          rotation: _currentPosition.heading,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationCarIcon,
          infoWindow: InfoWindow(title: 'Tu'),
          onDragEnd: ((value) {})),
    );
    markers.add(
      Marker(
          onTap: () {
            print('Tapped');
          },
          draggable: true,
          markerId: MarkerId('Tu'),
          position: LatLng(widget.latitud, widget.longitud),
          rotation: _currentPosition.heading,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: pinLocationUserIcon,
          infoWindow: InfoWindow(title: 'Tu'),
          onDragEnd: ((value) {})),
    );
    return markers;
  } */

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
          body:
              /*  _initialPosition == null
              ? Container(
                  child: Center(
                    child: Text(
                      'loading map..',
                      style: TextStyle(
                          fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                    ),
                  ),
                )
              :  */
              _child),
    );
  }

  Widget mapWidget() {
    return Stack(
      children: <Widget>[
        /* Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          color: Colors.white,
        ), */
        Container(
          width: deviceWidth(context),
          height: deviceHeight(context),
          color: Colors.white,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            //myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            //UN MARCADOR
            markers: Set.of((markers != null) ? [marker] : []),

            //PARA UTILIZAR VARIOS MARCADORES
            //markers: markers != null ? Set<Marker>.from(markers) : null,
            //markers: _createMarker(),
            compassEnabled: true,
            //myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentPosition.latitude, _currentPosition.longitude),
                zoom: 16.0),
          ),
        ),
      ],
    );
  }
}
