import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatmed/model/chatmodel.dart';

class ChatProvider {
  final _url = 'https://si1ex2med-default-rtdb.firebaseio.com';

  Future adicionarHistorial(ChatModel chat) async {
    final url = Uri.parse('$_url/chat.json');
    final response = await http.post(url, body: chatModelToJson(chat));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<List<ChatModel>> getHistorial(String correo) async {
    // ChatModel temporal;
    final url = Uri.parse('$_url/chat.json');
    final resp = await http.get(url);
    print("status code");
    if (resp.statusCode == 200) {
      print("status code 200");
      final Map<String, dynamic> decodeData = json.decode(resp.body);
      if (decodeData == null) {
        return null;
      }
      List<ChatModel> chat = [];
      decodeData.forEach((id, value) {
        final ChatModel tempModel = ChatModel.fromJson(value);
        if (tempModel.user == correo || tempModel.dir == correo) {
          chat.add(tempModel);
        }
      });
      chat.sort((a, b) {
        return a.date_time.compareTo(b.date_time);
      });
      return chat;
    } else {
      print("status code null");
      return null;
    }
  }
}
