import 'dart:convert';
//import 'dart:core';
//import 'package:examen/view/chat.dart';
//import 'package:dialogflow_grpc/generated/google/type/date.pb.dart';
import 'package:http/http.dart' as http;
import 'package:chatmed/model/citamodel.dart';

class CitaProvider {
  final _url = 'https://si1ex2med-default-rtdb.firebaseio.com';

  Future adicionarCita(citaModel cita) async {
    final url = Uri.parse('$_url/cita.json');
    final response = await http.post(url, body: citaModelToJson(cita));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  // Future<citaModel> obtenerUltimaCita(String turno) async {
  //   final url = Uri.parse('$_url/cita.json');
  //   final resp = await http.get(url);
  //   if (resp.statusCode == 200) {
  //     final Map<String, dynamic> decodeData = json.decode(resp.body);
  //     if (decodeData == null) {
  //       return null;
  //     }
  //     DateTime date_aux = new DateTime(1900, 1, 1);
  //     decodeData.forEach((id, value) {
  //       final citaModel tempModel = citaModel.fromJson(value);
  //       DateTime fecha = DateTime.parse(tempModel.date_time);
  //       if (fecha.isAfter(date_aux)) {
  //         date_aux = fecha;
  //       }
  //     });

  //     return chat;
  //   } else {
  //     print("status code null");
  //     return null;
  //   }
  // }

  // String getFormattedDate(String date) {
  //   /// Convert into local date format.
  //   var localDate = DateTime.parse(date).toLocal();

  //   /// inputFormat - format getting from api or other func.
  //   /// e.g If 2021-05-27 9:34:12.781341 then format should be yyyy-MM-dd HH:mm
  //   /// If 27/05/2021 9:34:12.781341 then format should be dd/MM/yyyy HH:mm
  //   var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
  //   var inputDate = inputFormat.parse(localDate.toString());

  //   /// outputFormat - convert into format you want to show.
  //   var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
  //   var outputDate = outputFormat.format(inputDate);

  //   return outputDate.toString();
  // }

  // Future adicionarHistorial(CitaModel chat) async {
  //   final url = Uri.parse('$_url/chat.json');
  //   final resp = await http.post(url, body: chatModelToJson(chat));
  //   return resp;
  // }

//   Future<List<ChatModel>> getHistorial(String usuario) async {
//     // ChatModel temporal;
//     final url = Uri.parse('$_url/chat.json');
//     final resp = await http.get(url);
//     print("status code");
//     if (resp.statusCode == 200) {
//       print("status code 200");
//       final Map<String, dynamic> decodeData = json.decode(resp.body);
//       if (decodeData == null) {
//         return null;
//       }
//       List<ChatModel> chat = [];
//       decodeData.forEach((id, value) {
//         final ChatModel tempModel = ChatModel.fromJson(value);
//         if (tempModel.user == correo || tempModel.dir == correo) {
//           chat.add(tempModel);
//         }
//       });
//       chat.sort((a, b) {
//         return a.date_time.compareTo(b.date_time);
//       });
//       return chat;
//     } else {
//       print("status code null");
//       return null;
//     }
//   }
}
