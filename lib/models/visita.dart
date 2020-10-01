
import 'dart:convert';

Visita visitaFromJson(String str) => Visita.fromJson(json.decode(str));

String visitaToJson(Visita data) => json.encode(data.toJson());

class Visita {
    Visita({
        this.success,
    });

    String success;

    factory Visita.fromJson(Map<String, dynamic> json) => Visita(
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
    };
}
