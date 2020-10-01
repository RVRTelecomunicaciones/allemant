import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_base_helper.dart';

class InspeccionDetailRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Inspeccion> fetchInspeccionDetail(String coordinacionID) async {
    final response = await _helper.get("operaciones/inspecciones/listAppInspeccionCoordinacionId/$coordinacionID");
    return Inspeccion.fromJson(response);
  }
}
