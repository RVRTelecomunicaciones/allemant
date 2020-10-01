import 'dart:async';
import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_response.dart';
import 'package:business/repository/inspeccion_detail_repository.dart';

class InspeccionDetailBloc {
  InspeccionDetailRepository _inspeccionDetailRepository;

  StreamController _inspeccionDetailController;

  StreamSink<ApiResponse<Inspeccion>> get inspeccionDetailSink =>
      _inspeccionDetailController.sink;

  Stream<ApiResponse<Inspeccion>> get inspeccionDetailStream =>
      _inspeccionDetailController.stream;

  InspeccionDetailBloc(coordinacionId) {
    _inspeccionDetailController = StreamController<ApiResponse<Inspeccion>>();
    _inspeccionDetailRepository = InspeccionDetailRepository();
    fetchInspeccionDetail(coordinacionId);
  }

  fetchInspeccionDetail(coordinacionId) async {
    inspeccionDetailSink.add(ApiResponse.loading('HOJA DE COORDINACIÓN'));
    try {
      Inspeccion details = await _inspeccionDetailRepository
          .fetchInspeccionDetail(coordinacionId);
      inspeccionDetailSink.add(ApiResponse.completed(details));
    } catch (e) {
      inspeccionDetailSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _inspeccionDetailController?.close();
  }
}
