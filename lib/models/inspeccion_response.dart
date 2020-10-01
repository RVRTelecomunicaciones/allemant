class InspeccionList {
  final List<Inspeccion> inspecciones;

  InspeccionList({this.inspecciones});

  factory InspeccionList.fromJson(List<dynamic> parsedJson) {
    List<Inspeccion> inspecciones = new List<Inspeccion>();
    inspecciones = parsedJson.map((i) => Inspeccion.fromJson(i)).toList();

    return new InspeccionList(inspecciones: inspecciones);
  }
}

/* 
class Inspeccion {
    String cotizacionId;
    String coordinacionId;
    String coordinacionCorrelativo;
    String riesgoId;
    String riesgoNombre;
    String coordinadorId;
    String coordinadorNombre;
    String fechaSolicitud;
    String entregaAlClienteFecha;
    String fechaEntrega;
    String solicitanteId;
    String solicitanteNombre;
    String contactoId;
    String contactoNombre;
    String clienteId;
    String clienteNombre;
    String servicioTipoId;
    String servicioTipoNombre;
    String tipoCambioId;
    String tipoCambioNombre;
    String tipoInspeccionId;
    String tipoInspeccionNombre;
    String modalidadId;
    String modalidadNombre;
    String inspeccionId;
    String peritoId;
    String peritoNombre;
    String inspeccionContacto;
    String inspeccionFecha;
    DateTime inspeccionFechaNormal;
    String inspeccionHora;
    String inspeccionHoraTipo;
    String distritoId;
    String distritoNombre;
    String provinciaId;
    String provinciaNombre;
    String departamentoId;
    String departamentoNombre;
    String inspeccionDireccion;
    String inspeccionLatitud;
    String inspeccionLongitud;
    String inspeccionObservacion;
    String estadoId;
    String estadoNombre;
    String infoStatus;
    String digitadorId;
    String digitadorNombre;
    String controlCalidadId;
    String controlCalidadNombre;

    Inspeccion({
        this.cotizacionId,
        this.coordinacionId,
        this.coordinacionCorrelativo,
        this.riesgoId,
        this.riesgoNombre,
        this.coordinadorId,
        this.coordinadorNombre,
        this.fechaSolicitud,
        this.entregaAlClienteFecha,
        this.fechaEntrega,
        this.solicitanteId,
        this.solicitanteNombre,
        this.contactoId,
        this.contactoNombre,
        this.clienteId,
        this.clienteNombre,
        this.servicioTipoId,
        this.servicioTipoNombre,
        this.tipoCambioId,
        this.tipoCambioNombre,
        this.tipoInspeccionId,
        this.tipoInspeccionNombre,
        this.modalidadId,
        this.modalidadNombre,
        this.inspeccionId,
        this.peritoId,
        this.peritoNombre,
        this.inspeccionContacto,
        this.inspeccionFecha,
        this.inspeccionFechaNormal,
        this.inspeccionHora,
        this.inspeccionHoraTipo,
        this.distritoId,
        this.distritoNombre,
        this.provinciaId,
        this.provinciaNombre,
        this.departamentoId,
        this.departamentoNombre,
        this.inspeccionDireccion,
        this.inspeccionLatitud,
        this.inspeccionLongitud,
        this.inspeccionObservacion,
        this.estadoId,
        this.estadoNombre,
        this.infoStatus,
        this.digitadorId,
        this.digitadorNombre,
        this.controlCalidadId,
        this.controlCalidadNombre,
    });


    factory Inspeccion.fromJson(Map<String, dynamic> json) => Inspeccion(
        cotizacionId: json["cotizacion_id"],
        coordinacionId: json["coordinacion_id"],
        coordinacionCorrelativo: json["coordinacion_correlativo"],
        riesgoId: json["riesgo_id"],
        riesgoNombre: json["riesgo_nombre"],
        coordinadorId: json["coordinador_id"],
        coordinadorNombre: json["coordinador_nombre"],
        fechaSolicitud: json["fecha_solicitud"],
        entregaAlClienteFecha: json["entrega_al_cliente_fecha"],
        fechaEntrega: json["fecha_entrega"],
        solicitanteId: json["solicitante_id"],
        solicitanteNombre: json["solicitante_nombre"],
        contactoId: json["contacto_id"],
        contactoNombre: json["contacto_nombre"],
        clienteId: json["cliente_id"],
        clienteNombre: json["cliente_nombre"],
        servicioTipoId: json["servicio_tipo_id"],
        servicioTipoNombre: json["servicio_tipo_nombre"],
        tipoCambioId: json["tipo_cambio_id"],
        tipoCambioNombre: json["tipo_cambio_nombre"],
        tipoInspeccionId: json["tipo_inspeccion_id"],
        tipoInspeccionNombre: json["tipo_inspeccion_nombre"],
        modalidadId: json["modalidad_id"],
        modalidadNombre: json["modalidad_nombre"],
        inspeccionId: json["inspeccion_id"],
        peritoId: json["perito_id"],
        peritoNombre: json["perito_nombre"],
        inspeccionContacto: json["inspeccion_contacto"],
        inspeccionFecha: json["inspeccion_fecha"],
        inspeccionFechaNormal: DateTime.parse(json["inspeccion_fecha_normal"]),
        inspeccionHora: json["inspeccion_hora"],
        inspeccionHoraTipo: json["inspeccion_hora_tipo"],
        distritoId: json["distrito_id"],
        distritoNombre: json["distrito_nombre"],
        provinciaId: json["provincia_id"],
        provinciaNombre: json["provincia_nombre"],
        departamentoId: json["departamento_id"],
        departamentoNombre: json["departamento_nombre"],
        inspeccionDireccion: json["inspeccion_direccion"],
        inspeccionLatitud: json["inspeccion_latitud"],
        inspeccionLongitud: json["inspeccion_longitud"],
        inspeccionObservacion: json["inspeccion_observacion"],
        estadoId: json["estado_id"],
        estadoNombre: json["estado_nombre"],
        infoStatus: json["info_status"],
        digitadorId: json["digitador_id"],
        digitadorNombre: json["digitador_nombre"],
        controlCalidadId: json["control_calidad_id"],
        controlCalidadNombre: json["control_calidad_nombre"],
    );

    Map<String, dynamic> toJson() => {
        "cotizacion_id": cotizacionId,
        "coordinacion_id": coordinacionId,
        "coordinacion_correlativo": coordinacionCorrelativo,
        "riesgo_id": riesgoId,
        "riesgo_nombre": riesgoNombre,
        "coordinador_id": coordinadorId,
        "coordinador_nombre": coordinadorNombre,
        "fecha_solicitud": fechaSolicitud,
        "entrega_al_cliente_fecha": entregaAlClienteFecha,
        "fecha_entrega": fechaEntrega,
        "solicitante_id": solicitanteId,
        "solicitante_nombre": solicitanteNombre,
        "contacto_id": contactoId,
        "contacto_nombre": contactoNombre,
        "cliente_id": clienteId,
        "cliente_nombre": clienteNombre,
        "servicio_tipo_id": servicioTipoId,
        "servicio_tipo_nombre": servicioTipoNombre,
        "tipo_cambio_id": tipoCambioId,
        "tipo_cambio_nombre": tipoCambioNombre,
        "tipo_inspeccion_id": tipoInspeccionId,
        "tipo_inspeccion_nombre": tipoInspeccionNombre,
        "modalidad_id": modalidadId,
        "modalidad_nombre": modalidadNombre,
        "inspeccion_id": inspeccionId,
        "perito_id": peritoId,
        "perito_nombre": peritoNombre,
        "inspeccion_contacto": inspeccionContacto,
        "inspeccion_fecha": inspeccionFecha,
        "inspeccion_fecha_normal": "${inspeccionFechaNormal.year.toString().padLeft(4, '0')}-${inspeccionFechaNormal.month.toString().padLeft(2, '0')}-${inspeccionFechaNormal.day.toString().padLeft(2, '0')}",
        "inspeccion_hora": inspeccionHora,
        "inspeccion_hora_tipo": inspeccionHoraTipo,
        "distrito_id": distritoId,
        "distrito_nombre": distritoNombre,
        "provincia_id": provinciaId,
        "provincia_nombre": provinciaNombre,
        "departamento_id": departamentoId,
        "departamento_nombre": departamentoNombre,
        "inspeccion_direccion": inspeccionDireccion,
        "inspeccion_latitud": inspeccionLatitud,
        "inspeccion_longitud": inspeccionLongitud,
        "inspeccion_observacion": inspeccionObservacion,
        "estado_id": estadoId,
        "estado_nombre": estadoNombre,
        "info_status": infoStatus,
        "digitador_id": digitadorId,
        "digitador_nombre": digitadorNombre,
        "control_calidad_id": controlCalidadId,
        "control_calidad_nombre": controlCalidadNombre,
    };
}
 */

class Inspeccion {
  String cotizacionId;
  String coordinacionId;
  String coordinacionCorrelativo;
  String riesgoId;
  String riesgoNombre;
  String coordinadorId;
  String coordinadorNombre;
  String fechaSolicitud;
  String entregaAlClienteFecha;
  String fechaEntrega;
  String solicitanteId;
  String solicitanteNombre;
  String contactoId;
  String contactoNombre;
  String clienteId;
  String clienteNombre;
  String servicioTipoId;
  String servicioTipoNombre;
  String tipoCambioId;
  String tipoCambioNombre;
  String tipoInspeccionId;
  String tipoInspeccionNombre;
  String modalidadId;
  String modalidadNombre;
  String inspeccionId;
  String peritoId;
  String peritoNombre;
  String inspeccionContacto;
  String inspeccionFecha;
  String inspeccionFechaNormal;
  String inspeccionHora;
  String inspeccionHoraTipo;
  String distritoId;
  String distritoNombre;
  String provinciaId;
  String provinciaNombre;
  String departamentoId;
  String departamentoNombre;
  String inspeccionDireccion;
  String inspeccionLatitud;
  String inspeccionLongitud;
  String inspeccionObservacion;
  String estadoId;
  String estadoNombre;
  String infoStatus;
  String digitadorId;
  String digitadorNombre;
  String controlCalidadId;
  String controlCalidadNombre;

  Inspeccion(
      {this.cotizacionId,
      this.coordinacionId,
      this.coordinacionCorrelativo,
      this.riesgoId,
      this.riesgoNombre,
      this.coordinadorId,
      this.coordinadorNombre,
      this.fechaSolicitud,
      this.entregaAlClienteFecha,
      this.fechaEntrega,
      this.solicitanteId,
      this.solicitanteNombre,
      this.contactoId,
      this.contactoNombre,
      this.clienteId,
      this.clienteNombre,
      this.servicioTipoId,
      this.servicioTipoNombre,
      this.tipoCambioId,
      this.tipoCambioNombre,
      this.tipoInspeccionId,
      this.tipoInspeccionNombre,
      this.modalidadId,
      this.modalidadNombre,
      this.inspeccionId,
      this.peritoId,
      this.peritoNombre,
      this.inspeccionContacto,
      this.inspeccionFecha,
      this.inspeccionFechaNormal,
      this.inspeccionHora,
      this.inspeccionHoraTipo,
      this.distritoId,
      this.distritoNombre,
      this.provinciaId,
      this.provinciaNombre,
      this.departamentoId,
      this.departamentoNombre,
      this.inspeccionDireccion,
      this.inspeccionLatitud,
      this.inspeccionLongitud,
      this.inspeccionObservacion,
      this.estadoId,
      this.estadoNombre,
      this.infoStatus,
      this.digitadorId,
      this.digitadorNombre,
      this.controlCalidadId,
      this.controlCalidadNombre});

  Inspeccion.fromJson(Map<String, dynamic> json) {
    cotizacionId = json['cotizacion_id'];
    coordinacionId = json['coordinacion_id'];
    coordinacionCorrelativo = json['coordinacion_correlativo'];
    riesgoId = json['riesgo_id'];
    riesgoNombre = json['riesgo_nombre'];
    coordinadorId = json['coordinador_id'];
    coordinadorNombre = json['coordinador_nombre'];
    fechaSolicitud = json['fecha_solicitud'];
    entregaAlClienteFecha = json['entrega_al_cliente_fecha'];
    fechaEntrega = json['fecha_entrega'];
    solicitanteId = json['solicitante_id'];
    solicitanteNombre = json['solicitante_nombre'];
    contactoId = json['contacto_id'];
    contactoNombre = json['contacto_nombre'];
    clienteId = json['cliente_id'];
    clienteNombre = json['cliente_nombre'];
    servicioTipoId = json['servicio_tipo_id'];
    servicioTipoNombre = json['servicio_tipo_nombre'];
    tipoCambioId = json['tipo_cambio_id'];
    tipoCambioNombre = json['tipo_cambio_nombre'];
    tipoInspeccionId = json['tipo_inspeccion_id'];
    tipoInspeccionNombre = json['tipo_inspeccion_nombre'];
    modalidadId = json['modalidad_id'];
    modalidadNombre = json['modalidad_nombre'];
    inspeccionId = json['inspeccion_id'];
    peritoId = json['perito_id'];
    peritoNombre = json['perito_nombre'];
    inspeccionContacto = json['inspeccion_contacto'];
    inspeccionFecha = json['inspeccion_fecha'];
    inspeccionFechaNormal = json['inspeccion_fecha_normal'];
    inspeccionHora = json['inspeccion_hora'];
    inspeccionHoraTipo = json['inspeccion_hora_tipo'];
    distritoId = json['distrito_id'];
    distritoNombre = json['distrito_nombre'];
    provinciaId = json['provincia_id'];
    provinciaNombre = json['provincia_nombre'];
    departamentoId = json['departamento_id'];
    departamentoNombre = json['departamento_nombre'];
    inspeccionDireccion = json['inspeccion_direccion'];
    inspeccionLatitud = json['inspeccion_latitud'];
    inspeccionLongitud = json['inspeccion_longitud'];
    inspeccionObservacion = json['inspeccion_observacion'];
    estadoId = json['estado_id'];
    estadoNombre = json['estado_nombre'];
    infoStatus = json['info_status'];
    digitadorId = json['digitador_id'];
    digitadorNombre = json['digitador_nombre'];
    controlCalidadId = json['control_calidad_id'];
    controlCalidadNombre = json['control_calidad_nombre'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cotizacion_id'] = this.cotizacionId;
    data['coordinacion_id'] = this.coordinacionId;
    data['coordinacion_correlativo'] = this.coordinacionCorrelativo;
    data['riesgo_id'] = this.riesgoId;
    data['riesgo_nombre'] = this.riesgoNombre;
    data['coordinador_id'] = this.coordinadorId;
    data['coordinador_nombre'] = this.coordinadorNombre;
    data['fecha_solicitud'] = this.fechaSolicitud;
    data['entrega_al_cliente_fecha'] = this.entregaAlClienteFecha;
    data['fecha_entrega'] = this.fechaEntrega;
    data['solicitante_id'] = this.solicitanteId;
    data['solicitante_nombre'] = this.solicitanteNombre;
    data['contacto_id'] = this.contactoId;
    data['contacto_nombre'] = this.contactoNombre;
    data['cliente_id'] = this.clienteId;
    data['cliente_nombre'] = this.clienteNombre;
    data['servicio_tipo_id'] = this.servicioTipoId;
    data['servicio_tipo_nombre'] = this.servicioTipoNombre;
    data['tipo_cambio_id'] = this.tipoCambioId;
    data['tipo_cambio_nombre'] = this.tipoCambioNombre;
    data['tipo_inspeccion_id'] = this.tipoInspeccionId;
    data['tipo_inspeccion_nombre'] = this.tipoInspeccionNombre;
    data['modalidad_id'] = this.modalidadId;
    data['modalidad_nombre'] = this.modalidadNombre;
    data['inspeccion_id'] = this.inspeccionId;
    data['perito_id'] = this.peritoId;
    data['perito_nombre'] = this.peritoNombre;
    data['inspeccion_contacto'] = this.inspeccionContacto;
    data['inspeccion_fecha'] = this.inspeccionFecha;
    data['inspeccion_fecha_normal'] = this.inspeccionFechaNormal;
    data['inspeccion_hora'] = this.inspeccionHora;
    data['inspeccion_hora_tipo'] = this.inspeccionHoraTipo;
    data['distrito_id'] = this.distritoId;
    data['distrito_nombre'] = this.distritoNombre;
    data['provincia_id'] = this.provinciaId;
    data['provincia_nombre'] = this.provinciaNombre;
    data['departamento_id'] = this.departamentoId;
    data['departamento_nombre'] = this.departamentoNombre;
    data['inspeccion_direccion'] = this.inspeccionDireccion;
    data['inspeccion_latitud'] = this.inspeccionLatitud;
    data['inspeccion_longitud'] = this.inspeccionLongitud;
    data['inspeccion_observacion'] = this.inspeccionObservacion;
    data['estado_id'] = this.estadoId;
    data['estado_nombre'] = this.estadoNombre;
    data['info_status'] = this.infoStatus;
    data['digitador_id'] = this.digitadorId;
    data['digitador_nombre'] = this.digitadorNombre;
    data['control_calidad_id'] = this.controlCalidadId;
    data['control_calidad_nombre'] = this.controlCalidadNombre;
    return data;
  }
}
