import 'dart:async';

import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_response.dart';
import 'package:business/repository/inspeccion_repository.dart';

class InspeccionBloc {

  InspeccionRepository _inspeccionRepository;
  StreamController _inspeccionListController;

  StreamSink<ApiResponse<List<Inspeccion>>> get inspeccionListSink =>
      _inspeccionListController.sink;

  Stream<ApiResponse<List<Inspeccion>>> get inspeccionListStream =>
      _inspeccionListController.stream;

  InspeccionBloc() {
    _inspeccionListController = StreamController<ApiResponse<List<Inspeccion>>>();
    _inspeccionRepository = InspeccionRepository();
    fetchInspeccionList();
  }

  fetchInspeccionList() async {

    inspeccionListSink.add(ApiResponse.loading("Lista de Inspecciones"));

    try {
      List<Inspeccion> inspecciones = await _inspeccionRepository.fetchListInspeccion();
      inspeccionListSink.add(ApiResponse.completed(inspecciones));
    } catch (e) {
      inspeccionListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _inspeccionListController?.close();
  }
}
