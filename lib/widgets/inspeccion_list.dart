import 'package:business/blocs/inspeccion_bloc.dart';
import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_response.dart';
import 'package:business/widgets/inspeccion_detail.dart';
import 'package:business/widgets/inspeccion_tipo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/cupertino.dart';

class InspeccionScreen extends StatefulWidget {
  final topContainerInput;
  InspeccionScreen({Key key, this.topContainerInput}) : super(key: key);

  @override
  _InspeccionScreenState createState() => _InspeccionScreenState();
}

class _InspeccionScreenState extends State<InspeccionScreen> {
  InspeccionBloc _bloc;
  final InspeccionTipoScroller categoriesScroller = InspeccionTipoScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  @override
  void initState() {
    super.initState();
    _bloc = InspeccionBloc();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
    //_bloc.fetchInspeccionList();
  }

  @override
  Widget build(BuildContext context) {
/*     return Expanded(
        child: StreamBuilder<ApiResponse<List<Inspeccion>>>(
            stream: _bloc.inspeccionListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return InspeccionList(inspeccionList: snapshot.data.data);
              }
              return Container();
            })); */

    return RefreshIndicator(
      onRefresh: () => _bloc.fetchInspeccionList(),
      child: StreamBuilder<ApiResponse<List<Inspeccion>>>(
        stream: _bloc.inspeccionListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return InspeccionList(inspeccionList: snapshot.data.data);
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

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class InspeccionList extends StatefulWidget {
  final List<Inspeccion> inspeccionList;
  final double topContainer;

  const InspeccionList({Key key, this.inspeccionList, this.topContainer})
      : super(key: key);

  @override
  _InspeccionListState createState() => _InspeccionListState();
}

class _InspeccionListState extends State<InspeccionList> {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Container(
        child: ListView.builder(
            controller: controller,
            itemCount: widget.inspeccionList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              double scale = 1.0;
              print(widget.topContainer);
              if (widget.topContainer > 0.5) {
                scale = index + 0.5 - widget.topContainer;
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
                    alignment: Alignment.topCenter,
                    child: Align(
                      heightFactor: 0.7,
                      alignment: Alignment.topCenter,
                      child: InkWell(
                        child: Container(
                          height: 170,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.blueGrey,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "COORDINACIÓNes: " +
                                            widget.inspeccionList[index]
                                                .coordinacionCorrelativo,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.fade,
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        widget.inspeccionList[index]
                                            .solicitanteNombre,
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        softWrap: false,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(FontAwesome.calendar),
                                          SizedBox(width: 8),
                                          Text(
                                            widget.inspeccionList[index]
                                                .inspeccionFecha,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                            /* overflow: TextOverflow.fade,
                                      maxLines: 2,
                                       softWrap: false, */
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(FontAwesome.clock_o),
                                          SizedBox(width: 8),
                                          Text(
                                            widget.inspeccionList[index]
                                                .inspeccionHora,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                            /* overflow: TextOverflow.fade,
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => InspeccionDetail(widget
                                  .inspeccionList[index].coordinacionId)));
                        },
                      ),
                    ),
                  ));
            }));
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
