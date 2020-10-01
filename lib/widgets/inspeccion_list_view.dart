import 'package:business/blocs/inspeccion_bloc.dart';
import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_response.dart';
import 'package:business/widgets/inspeccion_detail.dart';
import 'package:business/widgets/inspeccion_tipo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class InspeccionView extends StatefulWidget {
  final Size mySize;
  final double myCategoryHeight;

  InspeccionView({Key key, this.mySize, this.myCategoryHeight})
      : super(key: key);

  @override
  _InspeccionViewState createState() => _InspeccionViewState();
}

class _InspeccionViewState extends State<InspeccionView> {
  InspeccionBloc _bloc;
  final InspeccionTipoScroller categoriesScroller = InspeccionTipoScroller();

  ScrollController controller = ScrollController();
  double topContainer = 0;
  bool closeTopContainer = false;

  @override
  void initState() {
    super.initState();

    _bloc = InspeccionBloc();
    controller.addListener(() {
      double value = controller.offset / 119;
      setState(() {
        /*   print("CONDICION FALSE"); */

        topContainer = value;
        /* print("topContainer");
        print(topContainer); */
        closeTopContainer = controller.offset > 50;
        /* print("closeTopContainer");

        print(widget.closeTopContainer); */
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<ApiResponse<List<Inspeccion>>>(
        stream: _bloc.inspeccionListStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return Expanded(
                    child: Column(
                  children: <Widget>[
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: closeTopContainer ? 0 : 1,
                      child: AnimatedContainer(
                          //color: Colors.amber,
                          duration: const Duration(milliseconds: 200),
                          width: widget.mySize.width,
                          alignment: Alignment.topCenter,
                          height:
                              closeTopContainer ? 0 : widget.myCategoryHeight,
                          child: categoriesScroller),
                    ),
                    InspeccionList(
                        inspeccionList: snapshot.data.data,
                        topContainer: topContainer,
                        myscroller: controller)
                  ],
                ));

                /*  return InspeccionList(
                    inspeccionList: snapshot.data.data,
                    topContainer: topContainer,
                    myscroller: controller); */
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => _bloc.fetchInspeccionList(),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }
}

class InspeccionList extends StatelessWidget {
  final List<Inspeccion> inspeccionList;
  final ScrollController myscroller;
  final double topContainer;
  const InspeccionList(
      {Key key, this.inspeccionList, this.topContainer, this.myscroller})
      : super(key: key);

  Color getColor(String riesgoID) {
    if (riesgoID == "1") {
      return Colors.greenAccent[700];
    } else if (riesgoID == "2") {
      return Colors.yellowAccent[700];
    } else {
      return Colors.redAccent[700];
    }
  }

  Color getColorFont(String riesgoID) {
    if (riesgoID == "1") {
      return Colors.black;
    } else if (riesgoID == "2") {
      return Colors.black;
    } else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: myscroller,
        itemCount: inspeccionList.length,
        //shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          double scale = 1.0;
          if (topContainer > 0.5) {
            scale = index + 0.5 - topContainer;
            if (scale < 0) {
              scale = 0;
            } else if (scale > 1) {
              scale = 1;
            }
          }
          return Opacity(
            opacity: scale,
            child: Transform(
              transform: Matrix4.identity()..scale(scale, scale),
              alignment: Alignment.bottomCenter,
              child: Align(
                heightFactor: 0.7,
                alignment: Alignment.topCenter,
                child: InkWell(
                  child: Container(
                    height: 150,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: getColor(inspeccionList[index].riesgoId),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(80),
                              blurRadius: 10.0),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "COORDINACIÓN: " +
                                      inspeccionList[index]
                                          .coordinacionCorrelativo,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: getColorFont(
                                          inspeccionList[index].riesgoId),
                                      fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  inspeccionList[index].solicitanteNombre,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: getColorFont(
                                          inspeccionList[index].riesgoId)),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(FontAwesome.calendar,
                                        color: getColorFont(
                                            inspeccionList[index].riesgoId)),
                                    SizedBox(width: 8),
                                    Text(
                                      inspeccionList[index].inspeccionFecha,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: getColorFont(
                                              inspeccionList[index].riesgoId)),
                                      /* overflow: TextOverflow.fade,
                                        maxLines: 2,
                                         softWrap: false, */
                                    ),
                                    SizedBox(width: 16),
                                    Icon(
                                      FontAwesome.clock_o,
                                      color: getColorFont(
                                          inspeccionList[index].riesgoId),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      inspeccionList[index].inspeccionHora,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: getColorFont(
                                              inspeccionList[index].riesgoId)),
                                      /*color: Colors.grey para las letras 
                                      overflow: TextOverflow.fade,
                                        maxLines: 2,
                                         softWrap: false, */
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    /*  Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InspeccionDetail(
                            inspeccionList[index].coordinacionId))); */
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InspeccionDetail(
                            inspeccionList[index].coordinacionId)));
                  },
                ),
              ),
            ),
          );
        },
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
