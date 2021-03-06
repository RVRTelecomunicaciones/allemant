import 'package:business/models/inspeccion_response.dart';
import 'package:business/network/api_base_helper.dart';

class InspeccionRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Inspeccion>> fetchListInspeccion(String userID) async {
    final response =
        await _helper.get("operaciones/inspecciones/listAppInspeccion/$userID");

    // return MovieResponse.fromJson(response).results;

    return InspeccionList.fromJson(response).inspecciones;
  }
}
