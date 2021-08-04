import 'dart:convert';

citaModel citaModelFromJson(String str) => citaModel.fromJson(json.decode(str));
String citaModelToJson(citaModel data) => json.encode(data.toJson());

class citaModel {
  String nombre;
  String fecha;
  String especialista;
  String turno;
  String telefono;
  String user;
  String date_time;

  citaModel(
      {this.nombre,
      this.fecha,
      this.especialista,
      this.turno,
      this.telefono,
      this.user,
      this.date_time});

  factory citaModel.fromJson(Map<String, dynamic> json) => new citaModel(
        nombre: json["nombre"],
        fecha: json["fecha"],
        especialista: json["especialista"],
        turno: json["turno"],
        telefono: json["telefono"],
        user: json["user"],
        date_time: json["date_time"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "fecha": fecha,
        "especialista": especialista,
        "turno": turno,
        "telefono": telefono,
        "user": user,
        "date_time": date_time
      };
}
