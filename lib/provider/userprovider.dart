import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chatmed/model/usermodel.dart';

class UserProvider {
  final _url = 'https://si1ex2med-default-rtdb.firebaseio.com';

  Future crearUsuario(UserModel usuario) async {
    final url = Uri.parse('$_url/user.json');
    final response = await http.post(url, body: userModelToJson(usuario));
    if (response.statusCode == 200) {
      return response;
    } else {
      return null;
    }
  }

  Future<UserModel> getUsuario(String uid) async {
    UserModel temporal;
    final url = Uri.parse('$_url/user.json');
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    if (decodeData == null) {
      return null;
    }
    decodeData.forEach((id, value) {
      final tempModel = UserModel.fromJson(value);
      if (uid == tempModel.uid) {
        temporal = tempModel;
      }
    });
    return temporal;
  }
}
